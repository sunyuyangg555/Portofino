<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.manydesigns.elements.xml.XhtmlBuffer" %>
<%@ page import="com.manydesigns.portofino.dispatcher.Dispatch" %>
<%@ page import="com.manydesigns.portofino.dispatcher.DispatcherUtil" %>
<%@ page import="com.manydesigns.portofino.dispatcher.PageAction" %>
<%@ page import="com.manydesigns.portofino.logic.SecurityLogic" %>
<%@ page import="com.manydesigns.portofino.navigation.Navigation" %>
<%@ page import="com.manydesigns.portofino.navigation.NavigationItem" %>
<%@ page import="org.apache.shiro.SecurityUtils" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="app" scope="request" type="com.manydesigns.portofino.application.Application" />
<jsp:useBean id="actionBean" scope="request" type="net.sourceforge.stripes.action.ActionBean" />
<%
    Dispatch dispatch = DispatcherUtil.getDispatch(request, actionBean);
    boolean admin = SecurityLogic.isAdministrator(request);
    int startingLevel;
    int maxLevel;
    String param = request.getParameter("navigation.startingLevel");
    if(param != null) {
        startingLevel = Integer.parseInt(param);
    } else {
        startingLevel = dispatch.getPageInstancePath().length - dispatch.getClosestSubtreeRootIndex() - 2;
        if(startingLevel < 0) {
            startingLevel = 0;
        }
    }
    param = request.getParameter("navigation.maxLevel");
    if(param != null) {
        maxLevel = Integer.parseInt(param);
    } else {
        maxLevel = startingLevel + 2;
    }

    Navigation navigation = new Navigation(app, dispatch, SecurityUtils.getSubject(), admin);
    List<NavigationItem> navigationItems;
    NavigationItem rootNavigationItem = navigation.getRootNavigationItem();
    if (rootNavigationItem.isGhost() && !rootNavigationItem.isSelected()) {
        navigationItems = rootNavigationItem.getChildNavigationItems();
    } else {
        navigationItems = new ArrayList<NavigationItem>(1);
        navigationItems.add(rootNavigationItem);
    }
    boolean first = true;
    int level = 0;
    String title = "";
    while (!navigationItems.isEmpty()) {
        NavigationItem nextNavigationItem = null;
        if(level >= startingLevel) {
            if (first) {
                first = false;
                %><ul class="nav nav-list portofino-sidenav"><% //Con classe "afflix" la navbar rimane sempre visibile, ma bisogna dare width assoluta (Responsive)
            }
            %><li class="nav-header"><%= title %></li><%
        }
        for (NavigationItem current : navigationItems) {
            XhtmlBuffer xb = new XhtmlBuffer(out);
            if(level >= startingLevel) {
                xb.openElement("li");
                if (current.isInPath()) {
                    xb.addAttribute("class", "active");
                    nextNavigationItem = current;
                }
                xb.writeAnchor(current.getPath(), current.getTitle());
                xb.closeElement("li");
            } else if (current.isInPath()) {
                nextNavigationItem = current;
            }
        }
        if (nextNavigationItem != null && level < maxLevel) {
            navigationItems = nextNavigationItem.getChildNavigationItems();
            title = nextNavigationItem.getDescription();
        } else {
            navigationItems = Collections.EMPTY_LIST;
        }
        level++;
    }
    if(!first) {
        %></ul><%
    }
%>
