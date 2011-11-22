<%@ page contentType="text/html;charset=ISO-8859-1" language="java"
         pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes-dynattr.tld"%>
<%@taglib prefix="mde" uri="/manydesigns-elements"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="portofino" %>
<stripes:layout-render name="/skins/default/admin-page.jsp">
    <jsp:useBean id="actionBean" scope="request"
                 type="com.manydesigns.portofino.actions.user.admin.UserAdminAction"/>
    <stripes:layout-component name="contentHeader">
        <div class="breadcrumbs">
            <div class="inner">
                <mde:write name="breadcrumbs"/>
            </div>
        </div>
    </stripes:layout-component>
    <stripes:layout-component name="pageTitle">
        <c:out value="${actionBean.crud.readTitle}"/>
    </stripes:layout-component>
    <stripes:layout-component name="portletTitle">
        <c:out value="${actionBean.crud.readTitle}"/>
    </stripes:layout-component>
    <stripes:layout-component name="portletBody">
        <div class="yui-gc">
            <div class="yui-u first">
                <mde:write name="actionBean" property="form"/>
            </div>
            <div class="yui-u">
                <h2>Groups</h2>
                <ul>
                    <c:forEach items="${actionBean.userGroups}" var="group">
                        <li><a href="${actionBean.context.request.contextPath}/actions/admin/groups/${group.groupId}"><c:out value="${group.name}" /></a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <input type="hidden" name="pk" value="<c:out value="${actionBean.pk}"/>"/>
        <c:if test="${not empty actionBean.searchString}">
            <input type="hidden" name="searchString" value="<c:out value="${actionBean.searchString}"/>"/>
        </c:if>
        <input type="hidden" name="cancelReturnUrl" value="<c:out value="${actionBean.cancelReturnUrl}"/>"/>
    </stripes:layout-component>
    <stripes:layout-component name="portletFooter">
        <div class="crudReadButtons">
            <portofino:buttons list="crud-read" cssClass="portletButton" />
        </div>
    </stripes:layout-component>
    <stripes:layout-component name="contentFooter" />
    <script type="text/javascript">
        $(".crudReadButtons button[name=delete]").click(function() {
            return confirm ('Are you sure?');
        });
    </script>
</stripes:layout-render>