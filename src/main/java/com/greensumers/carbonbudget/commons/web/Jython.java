package com.greensumers.carbonbudget.commons.web;

import org.python.core.PyFunction;
import org.python.core.PyInteger;
import org.python.core.PyObject;
import org.python.util.PythonInterpreter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class Jython {
	
	 private static PythonInterpreter intPre;
	    @RequestMapping(value = "/test", method = RequestMethod.GET)
	    public String getTest() {
	        System.out.println("파이썬 코드 실행합니다 ");
	        System.setProperty("python.import.site", "flase");
	        intPre = new PythonInterpreter();
	        //파이썬 경로
	        intPre.execfile("C:\\dev\\pythonProject\\python_gui\\tk01.py");
	        intPre.exec("print('python running')");
	        PyFunction pyFuntion = (PyFunction) intPre.get("testFunc", PyFunction.class);
	        int a = 10, b = 20;
	        // 파라미터 주는 법
	        // PyObject pyobj = pyFuntion.__call__(new PyInteger(a), new PyInteger(b));
	        // 단순호출
	        PyObject pyobj = pyFuntion.__call__();
	        System.out.println(pyobj.toString());

	        return pyobj.toString();
	    }
}
