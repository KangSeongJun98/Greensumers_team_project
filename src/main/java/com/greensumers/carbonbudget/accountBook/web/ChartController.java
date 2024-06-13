package com.greensumers.carbonbudget.accountBook.web;

import java.util.ArrayList;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.greensumers.carbonbudget.accountBook.service.AbService;
import com.greensumers.carbonbudget.accountBook.vo.AccountSearchVO;
import com.greensumers.carbonbudget.accountBook.vo.ExcategoryVO;
import com.greensumers.carbonbudget.accountBook.vo.MonthExVO;
import com.greensumers.carbonbudget.accountBook.vo.MonthInVO;

@RestController
@RequestMapping("/api")
public class ChartController {
    
    private AbService service;

    public ChartController(AbService service) {
        this.service = service;
    }

    @GetMapping("/abView")
    public ApiResponse getAbChartData(AccountSearchVO searchVO) {
    	System.out.println(searchVO);
        ArrayList<MonthExVO> Moex = service.getmonthEx(searchVO);
        ArrayList<MonthInVO> Moin = service.getmonthIn(searchVO);
        ArrayList<ExcategoryVO> Exca = service.getExCategory(searchVO);

        // 여기서 Moex와 Moin을 JSON 응답으로 포장하여 반환합니다.
        // 이때 ApiResponse 클래스를 사용하여 JSON 응답을 만들어 반환합니다.
        System.out.println("Moex: "+Moex);
        System.out.println("Moin: "+Moin);
        System.out.println("Exca: "+Exca);
        return new ApiResponse(Moex, Moin, Exca);
    }
}
