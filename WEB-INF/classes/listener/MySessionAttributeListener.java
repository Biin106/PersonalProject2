package listener;

import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionAttributeListener;
import jakarta.servlet.http.HttpSessionBindingEvent;

@WebListener
public class MySessionAttributeListener implements HttpSessionAttributeListener {
	
	public MySessionAttributeListener() {
		System.out.println("MySessionAttributeListener의 생성자:Pre-loading");
	}

	@Override
	public void attributeAdded(HttpSessionBindingEvent se) {
		System.out.println("세션영역에 속성이 추가되었습니다");
		System.out.println(String.format("추가된 속성명:%s,속성값:%s",se.getName(),se.getValue()));
	}

	@Override
	public void attributeRemoved(HttpSessionBindingEvent se) {
		System.out.println("세션영역에 속성이 삭제되었습니다");
		System.out.println(String.format("삭제된 속성명:%s,속성값:%s",se.getName(),se.getValue()));
	}

	@Override
	public void attributeReplaced(HttpSessionBindingEvent se) {
		System.out.println("세션영역에 속성이 변경되었습니다");
		System.out.println(String.format("변경된 속성명:%s,속성값:%s",se.getName(),se.getValue()));
	}
	
}
