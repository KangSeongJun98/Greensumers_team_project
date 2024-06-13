from flask import Flask, request
from flask_cors import CORS
import numpy as np
import cv2
import easyocr
import re
import base64
import json
import cx_Oracle
import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity

app = Flask(__name__)
CORS(app)
reader = easyocr.Reader(['ko', 'en'])

def process_image(file_stream):

    nparr = np.frombuffer(file_stream, np.uint8)
    src = cv2.imdecode(nparr, cv2.IMREAD_COLOR)


    # src = cv2.imread(img_url, 1)
    gray = cv2.cvtColor(src, cv2.COLOR_BGR2GRAY)
    gray = cv2.GaussianBlur(gray, (3, 3), 0)

    canned = cv2.Canny(gray, 150, 300)

    kernel = np.ones((10, 1), np.uint8)
    mask = cv2.dilate(canned, kernel, iterations=20)

    contours, _ = cv2.findContours(mask, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

    biggest_cntr = max(contours, key=cv2.contourArea)

    rect = cv2.minAreaRect(biggest_cntr)
    box = cv2.boxPoints(rect)
    box = np.int_(box)

    angle = rect[-1]
    if angle > 45:
        angle = -(90 - angle)

    rotated = src.copy()
    (h, w) = rotated.shape[:2]
    center = (w // 2, h // 2)
    M = cv2.getRotationMatrix2D(center, angle, 1.0)
    rotated = cv2.warpAffine(rotated, M, (w, h), flags=cv2.INTER_CUBIC, borderMode=cv2.BORDER_REPLICATE)

    ones = np.ones(shape=(len(box), 1))
    points_ones = np.hstack([box, ones])
    transformed_box = M.dot(points_ones.T).T

    y = [transformed_box[0][1], transformed_box[1][1], transformed_box[2][1], transformed_box[3][1]]
    x = [transformed_box[0][0], transformed_box[1][0], transformed_box[2][0], transformed_box[3][0]]

    y1, y2 = int(min(y)), int(max(y))
    x1, x2 = int(min(x)), int(max(x))

    bbox_area = (x2 - x1) * (y2 - y1)

    bbox_area_threshold = 5000000

    if bbox_area > bbox_area_threshold:
        crop = rotated[y1:y2, x1:x2]
    else:
        crop = rotated

    gray2 = cv2.cvtColor(crop, cv2.COLOR_BGR2GRAY)

    h, w = gray2.shape[:2]

    x_rel1, y_rel1, w_rel1, h_rel1 = 0.6, 0.6, 0.5, 0.5
    x1, y1, w1, h1 = int(x_rel1 * w), int(y_rel1 * h), int(w_rel1 * w), int(h_rel1 * h)

    x_rel2, y_rel2, w_rel2, h_rel2 = 0.01, 0.5, 0.45, 0.15
    x2, y2, w2, h2 = int(x_rel2 * w), int(y_rel2 * h), int(w_rel2 * w), int(h_rel2 * h)

    roi1 = gray2[y1:y1 + h1, x1:x1 + w1]
    roi2 = gray2[y2:y2 + h2, x2:x2 + w2]

    result1 = reader.readtext(roi1, detail=0)
    result2 = reader.readtext(roi2, detail=0)

    keywords = {
        "전기": ["전기", "전기료", "진기", "젼기", "승강기전기료"],
        "수도": ["수도", "수도료", "주도", "주도료", "주로로", "주로"]
    }

    amount_pattern = re.compile(r'(\d{1,3}(,\d{3})*(\.\d+)?)')

    def map_keywords(text):
        for key, values in keywords.items():
            for value in values:
                if value in text:
                    return key
        return None

    def extract_info(results):
        extracted_info = {"전기": {"금액": []}, "수도": {"금액": []}}

        current_key = None

        for text in results:
            mapped_keyword = map_keywords(text)
            if mapped_keyword:
                current_key = mapped_keyword

            if current_key:
                amount = amount_pattern.findall(text)
                if amount:
                    amount_values = [amt[0] for amt in amount]
                    extracted_info[current_key]["금액"].extend(amount_values)

        return extracted_info

    def extract_specific_info(results):
        specific_info = {}
        key = None
        for text in results:
            if text == "전기" or text == "진기" or text == "젼기":
                key = "전기"
                specific_info[key] = []
            elif text == "수도" or text == "주도" or text == "주로":
                key = "수도"
                specific_info[key] = []
            elif text.isdigit() and key:
                specific_info[key].append(text)
        return specific_info

    info1 = extract_info(result1)
    info2 = extract_specific_info(result2)

    info_combined = {
        "전기": {"금액": info1["전기"]["금액"]},
        "수도": {"금액": info1["수도"]["금액"]}
    }

    info1 = {
        "전기": {"금액": [value for value in info_combined["전기"]["금액"] if ',' in value]},
        "수도": {"금액": [value for value in info_combined["수도"]["금액"] if ',' in value]}
    }

    final_info = [
        {"에너지": "전기", "금액": info1["전기"]["금액"][0], "사용량": (int(info2["전기"][1]) - int(info2["전기"][0]))},
        {"에너지": "수도", "금액": info1["수도"]["금액"][0], "사용량": (int(info2["수도"][1]) - int(info2["수도"][0]))}
    ]

    return final_info, roi1

@app.route('/OCRDo', methods=['POST'])
def get_data():
    # file_url = request.form.get('file_url', None)

    file_stream = request.files['file-url'].read()


    # if file_url is not None:
    #     file_url = file_url.strip()
    #     print("이미지 경로:", file_url)
    # else:
    #     print("파일 URL이 제공되지 않았습니다.")

    final_info, roi1 = process_image(file_stream)
    _, roi1_encoded = cv2.imencode('.jpg', roi1)
    roi1_base64 = base64.b64encode(roi1_encoded).decode('utf-8')
    response_data = {
        "final_info": final_info,
        "img": roi1_base64
    }
    # 한글 인코딩 문제를 해결
    return json.dumps(response_data, ensure_ascii=False)




@app.route('/SimilarityDo', methods=['POST'])
def get_mem_id():
    # 유사한 사용자
    # Oracle 데이터베이스 연결 정보
    dsn = cx_Oracle.makedsn("192.168.0.57", "1521", service_name="xe")
    connection = cx_Oracle.connect(user="greensumers", password="greensumers", dsn=dsn)

    # 쿼리 실행 및 데이터프레임으로 변환
    query = "SELECT MEM_ID, Q_ID, A_ID, C_DT FROM user_responses"
    df = pd.read_sql(query, con=connection)

    # 각 Q_ID 별로 A_ID의 고유 값들 찾기
    unique_answers = df.groupby('Q_ID')['A_ID'].unique()

    # 이진 매핑을 위한 데이터프레임 준비
    binary_df_list = []

    for q_id, answers in unique_answers.items():
        temp_df = df[df['Q_ID'] == q_id].copy()
        for answer in answers:
            # 각 Q_ID에 대해 A_ID의 존재 여부를 나타내는 새로운 열을 생성
            temp_df[f'Q{q_id}_A{answer}'] = (temp_df['A_ID'] == answer).astype(int)
        binary_df_list.append(
            temp_df.loc[:, ['MEM_ID'] + [col for col in temp_df.columns if col.startswith(f'Q{q_id}_A')]])

    # 모든 Q_ID에 대한 이진 데이터프레임을 합침
    binary_df = pd.concat(binary_df_list, axis=0).groupby('MEM_ID').max().reset_index()

    # 고객 프로파일 생성
    profiles = binary_df.set_index('MEM_ID')

    # 코사인 유사도 계산
    sim_matrix = cosine_similarity(profiles)
    sim_df = pd.DataFrame(sim_matrix, index=profiles.index, columns=profiles.index)

    # 결과 프로파일 데이터프레임 출력
    print(profiles.head())
    print(sim_df.head())

    # 타겟 사용자를 설정하고 유사한 사용자 찾기
    param = request.form.get('memId', None)
    print("param", param)
    target_user = param

    # 유사도가 높은 순서로 사용자 정렬하고 상위 3개 선택
    sorted_users = sim_df[target_user].sort_values(ascending=False).index[:3].tolist()

    # 자신과 동일한 이름을 제거
    #similar_users = [user for user in sorted_users if user != target_user]

    print(f"Users similar to {target_user}: {sorted_users}")
    connection.close()
    return sorted_users


if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0")
