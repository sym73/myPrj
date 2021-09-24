package com.myprj.prj.controller;

import com.myprj.prj.dao.UserDAO;
import com.myprj.prj.vo.BoardVo;
import com.myprj.prj.vo.UserVo;
import com.myprj.prj.vo.api06Vo;
import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
/** DAO 파일에서 @Mapper 미사용시 적용
 * @MapperScan(basePackages="com.myprj.prj.dao")//탐색할 패키시 설정
 */
public class Api01Controller {

    @Autowired
    private UserDAO userDAO;

    @GetMapping("api01")
    public String api01(Model model,
                        HttpServletResponse response,
                        HttpServletRequest request,
                        @RequestParam(name="par", required=false, defaultValue="11") String par) {

        //쿠리 생성
        Cookie setCookie = new Cookie("key", par); // 쿠키 이름을 name으로 생성
        setCookie.setMaxAge(60*60*24); // 기간을 하루로 지정(60초 * 60분 * 24시간)
        response.addCookie(setCookie); // response에 Cookie 추가

        //세션 생성
        HttpSession session = request.getSession();
        session.setAttribute("ID", "future");

        log.info("@@@@@@@ par={}", par);

        return "mo01";
    }

    /**
     * ResponseBody 적용
     */
    @RequestMapping("api02")
    @ResponseBody
    public Map<String, Object> api02( @RequestBody BoardVo board
                                    ) throws Exception {

        log.info("@@@@@ name:{}  content:{}", board.getName(), board.getContent() );

        HashMap<String, Object> map = new HashMap<String, Object>();

        map.put("userId", board.getName());

        List<HashMap<String, Object>> list = userDAO.selectUsers(map);

        for(int i=0;i<list.size();i++) {
            log.info("@@@@@ list1 --> {}", list.get(i).get("userNm") );
        }

        for(Map<String, Object> map1 : list) {
            log.info("@@@@@ list2 --> {}", map1.get("userNm") );
        }

        map.put("status","SUCCESS" );
        map.put("list", list);

        return map;
    }

    /**
     * ModelMap, Model 적용
     */
    @GetMapping("api03")
    public String api03(ModelMap modelmap, Model model,
                        HttpServletRequest request) {

        // 쿠키 조회
        Cookie[] getCookie = request.getCookies(); // 모든 쿠키 가져오기
        if(getCookie != null){ // 만약 쿠키가 없으면 쿠키 생성
            for(int i=0; i<getCookie.length; i++){
                Cookie c = getCookie[i]; // 객체 생성
                String name = c.getName(); // 쿠키 이름 가져오기
                String value = c.getValue(); // 쿠키 값 가져오기
                log.info("@@@@@@ cookie name={}, value={}", name, value);
            }
        }

        // 세션 조회
        HttpSession session = request.getSession();
        String id = (String) session.getAttribute("ID");
        if( id != null) {
            log.info("@@@@@@ Session id={}", id);
        }

        //세션 ID 조회
        log.info("@@@@@@ session.getId() = {}", session.getId() );

        modelmap.addAttribute("param1", "test:추가인자값");
        model.addAttribute("val1", "test");

        return "mo02";
    }

    /**
     * ModelAndView 적용
     */
    @GetMapping("api04")
    public  ModelAndView  api04() {
        ModelAndView mav = new ModelAndView();
        mav.addObject("param1", "test:추가인자값111");
        mav.setViewName("mo02");
        return mav;
    }


    @RequestMapping("api05")
    public ModelAndView api05() {
        ModelAndView mav = new ModelAndView("mo03");
        return mav;
    }


    /**
     * ResponseBody 적용
     */
    @RequestMapping("api06")
    @ResponseBody
    public Map<String, Object> api06( @RequestBody api06Vo api06
                                    ) throws Exception {

        log.info("@@@@@@ api06 status :{}", api06.getStatus() );
        log.info("@@@@@@ api06 LEN :{}", api06.getUserVo().size() );

        for(UserVo userVo: api06.getUserVo()) {
            log.info("@@@@@@ userId:{}, userNm:{}", userVo.getUserId(), userVo.getUserNm() );
        }

        HashMap<String, Object> map = new HashMap<String, Object>();

        map.put("status","SUCCESS" );

        return map;
    }


    /**
     *
     *  JSP에서 PORM 이 GET 방식으로  전송시
     */
    @RequestMapping("api07")
    public ModelAndView api07( HttpServletRequest request ,
                               @RequestParam(value="userId",required = false) String userId,
                               @RequestParam HashMap<String, Object> paraMap
                        ) throws Exception {

        log.info("@@@@@@111 userId:{}", request.getParameter("userId") );
        log.info("@@@@@@222 userId:{}", userId );
        log.info("@@@@@@ paraMap userId:{}, userNm:{}", paraMap.get("userId"), paraMap.get("userNm") );

        ModelAndView mav = new ModelAndView("mo04");

        String par1="AAAAAA";

        HashMap<String, Object> parTap = new HashMap<String, Object>();
        HashMap<String, Object> map = new HashMap<String, Object>();

        map.put("userId", userId );

        List<HashMap<String, Object>> list = userDAO.selectUsers(map);

        for(HashMap<String, Object> nmap : list ) {
            log.info("@@@@@@ name :{}", nmap.get("userNm") );
        }

        log.info("@@@@@@ list size :{}", list.size() );

        parTap.put("col1", "ZZZZZ");

        mav.addObject("items", list);
        mav.addObject("par1", par1);
        mav.addObject("parTap", parTap);

        return mav;

    }

    @RequestMapping(value="api08", method = RequestMethod.POST)
    public ModelAndView api08( HttpServletRequest request ,
                               @RequestBody MultiValueMap<String, Object> paraMap
    ) throws Exception {
        log.info("@@@@@@ POST @@@@@@@@@@@@@@@@@@@@@");

        Map<String, Object> map2 = paraMap.toSingleValueMap();

        String userId = (String) map2.get("userId");

        ModelAndView mav = new ModelAndView("mo04");

        String par1="AAAAAA";

        HashMap<String, Object> parTap = new HashMap<String, Object>();
        HashMap<String, Object> map = new HashMap<String, Object>();

        map.put("userId", userId );

        List<HashMap<String, Object>> list = userDAO.selectUsers(map);

        for(HashMap<String, Object> nmap : list ) {
            log.info("@@@@@@ name :{}", nmap.get("userNm") );
        }

        log.info("@@@@@@ list size :{}", list.size() );

        parTap.put("col1", "ZZZZZ");

        mav.addObject("items", list);
        mav.addObject("par1", par1);
        mav.addObject("parTap", parTap);

        return mav;
    }

    @RequestMapping("page01")
    public ModelAndView page01() {
        ModelAndView mav = new ModelAndView("page01");
        return mav;
    }
}
