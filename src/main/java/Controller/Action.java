package Controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface Action {
	public abstract ActionForward execute(HttpServletRequest request, 
			HttpServletResponse response) throws Exception;	
}
