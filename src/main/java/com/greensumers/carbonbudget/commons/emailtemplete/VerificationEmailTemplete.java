package com.greensumers.carbonbudget.commons.emailtemplete;

public class VerificationEmailTemplete {
	// 코드가 필요해서 메서드 수정
	public static String registerEmailContent(String code) {
		return "<!DOCTYPE html>\n" +
				"<head>\n" +
				"    <meta charset=\"UTF-8\">\n" +
				"    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
				"    <title>Demistifying Email Design</title>\n" +
				"</head>\n" +
				"<body style=\"margin: 0; padding: 0;\">\n" +
				"    <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" style=\"border-collapse: collapse;\">\n" +
				"        <tr>\n" +
				"            <td>\n" +
				"                <hr style=\"border-width: 4px; border-color: #7dd043; border-style: solid;\">\n" +
				"            </td>\n" +
				"        </tr>\n" +
				"        <tr>\n" +
				"            <td style=\"padding-top: 10px;\">\n" +
				"                <strong>Greensumers</strong>" +
				"            </td>\n" +
				"        </tr>\n" +
				"        <tr>\n" +
				"            <td>\n" +
				"                <h2><span style=\"color: lightgreen;\">이메일 인증</span> 안내입니다.</h2>\n" +
				"            </td>\n" +
				"        </tr>\n" +
				"        <tr>\n" +
				"            <td style=\"padding-top: 40px; padding-bottom: 40px;\">\n" +
				"                새로운 계정 생성 프로세스를 시작해 주셔서 감사합니다. 사용자가 본인임을 확인하려고 합니다. 메시지가 표시되면 아래의 확인 코드를 입력하세요. 계정을 생성하지 않는 경우에는 이 메시지를 무시해도 됩니다.\n" +
				"            </td>\n" +
				"        </tr>\n" +
				"        <tr>\n" +
				"            <td style=\"padding-bottom: 20px\">\n" +
				"                확인 코드:<br>\n" +
				"                <strong><span style=\"font-size: 1cm;\">" + code + "</span></strong>\n" +
				"            </td>\n" +
				"        </tr>\n" +
				"        <tr>\n" +
				"            <td>\n" +
				"                <hr style=\"border-width: 4px; border-color: #7dd043; border-style: solid;\">\n" +
				"            </td>\n" +
				"        </tr>\n" +
				"    </table>\n" +
				"</body>\n" +
				"</html>";
	}
	
	
	public static String temporaryPasswordEmailContent(String code) {
		return "<!DOCTYPE html>\n" +
				"<head>\n" +
				"    <meta charset=\"UTF-8\">\n" +
				"    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
				"    <title>Demistifying Email Design</title>\n" +
				"</head>\n" +
				"<body style=\"margin: 0; padding: 0;\">\n" +
				"    <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" style=\"border-collapse: collapse;\">\n" +
				"        <tr>\n" +
				"            <td>\n" +
				"                <hr style=\"border-width: 4px; border-color: #7dd043; border-style: solid;\">\n" +
				"            </td>\n" +
				"        </tr>\n" +
				"        <tr>\n" +
				"            <td style=\"padding-top: 10px;\">\n" +
				"                <strong>Greensumers</strong>" +
				"            </td>\n" +
				"        </tr>\n" +
				"        <tr>\n" +
				"            <td>\n" +
				"                <h2><span style=\"color: lightgreen;\">임시 비밀번호</span> 안내입니다.</h2>\n" +
				"            </td>\n" +
				"        </tr>\n" +
				"        <tr>\n" +
				"            <td style=\"padding-top: 40px; padding-bottom: 40px;\">\n" +
				"                요청하신 대로 귀하의 계정에 대한 임시 비밀번호를 생성하였습니다. 아래의 상세 정보를 확인해 주세요.\n" +
				"            </td>\n" +
				"        </tr>\n" +
				"        <tr>\n" +
				"            <td style=\"padding-bottom: 20px\">\n" +
				"                임시 비밀번호:<br>\n" +
				"                <strong><span style=\"font-size: 1cm;\">" + code + "</span></strong>\n" +
				"            </td>\n" +
				"        </tr>\n" +
				"        <tr>\n" +
				"            <td style=\"padding-top: 40px; padding-bottom: 20px;\">\n" +
				"                보안상의 이유로, 로그인 후 가능한 한 빨리 이 비밀번호를 변경하시기를 권장드립니다. 비밀번호 변경 절차는 다음과 같습니다.\n" +
				"            </td>\n" +
				"        </tr>\n" +
				"        <tr>\n" +
				"            <td style=\"padding-top: 20px; padding-bottom: 10px;\">\n" +
				"                1. 임시 비밀번호를 사용하여 계정에 로그인합니다.\n" +
				"            </td>\n" +
				"        </tr>\n" +
				"        <tr>\n" +
				"            <td style=\"padding-top: 10px; padding-bottom: 10px;\">\n" +
				"                2. 마이페이지로 이동합니다.\n" +
				"            </td>\n" +
				"        </tr>\n" +
				"        <tr>\n" +
				"            <td style=\"padding-top: 10px; padding-bottom: 20px;\">\n" +
				"                3. 임시 비밀번호를 입력하고, 새 비밀번호를 설정합니다.\n" +
				"            </td>\n" +
				"        </tr>\n" +
				"        <tr>\n" +
				"            <td style=\"padding-top: 20px; padding-bottom: 10px;\">\n" +
				"                임시 비밀번호를 요청하지 않으셨거나, 문의 사항이 있으시면 즉시 저희 지원팀에 연락해주세요.\n" +
				"            </td>\n" +
				"        </tr>\n" +
				"        <tr>\n" +
				"            <td style=\"padding-top: 30px; padding-bottom: 40px;\">\n" +
				"                감사합니다.\n" +
				"            </td>\n" +
				"        </tr>\n" +
				"        <tr>\n" +
				"            <td>\n" +
				"                <hr style=\"border-width: 4px; border-color: #7dd043; border-style: solid;\">\n" +
				"            </td>\n" +
				"        </tr>\n" +
				"    </table>\n" +
				"</body>\n" +
				"</html>";
	}
	
}
