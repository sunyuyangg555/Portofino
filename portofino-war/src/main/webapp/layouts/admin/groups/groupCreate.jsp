<%@ page contentType="text/html;charset=ISO-8859-1" language="java"
         pageEncoding="ISO-8859-1"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes-dynattr.tld"
%><%@ taglib prefix="mde" uri="/manydesigns-elements"
%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
%><%@ taglib tagdir="/WEB-INF/tags" prefix="portofino" %>

<stripes:layout-render name="/skins/default/admin-page.jsp">
    <jsp:useBean id="actionBean" scope="request" type="com.manydesigns.portofino.actions.CrudAction"/>
    <stripes:layout-component name="contentHeader">
        <portofino:buttons list="crud-create" cssClass="contentButton" />
    </stripes:layout-component>
    <stripes:layout-component name="pageTitle">
        <c:out value="${actionBean.crud.createTitle}"/>
    </stripes:layout-component>
    <stripes:layout-component name="portletTitle">
        <c:out value="${actionBean.crud.createTitle}"/>
    </stripes:layout-component>
    <stripes:layout-component name="portletBody">
        <c:if test="${actionBean.requiredFieldsPresent}">
            <fmt:message key="commons.fields_required"/>
        </c:if>
        <mde:write name="actionBean" property="form"/>
        <input type="hidden" name="pk" value="<c:out value="${actionBean.pk}"/>"/>
        <input type="hidden" name="cancelReturnUrl" value="<c:out value="${actionBean.cancelReturnUrl}"/>"/>
    </stripes:layout-component>
    <stripes:layout-component name="portletFooter"/>
    <stripes:layout-component name="contentFooter">
        <portofino:buttons list="crud-create" cssClass="contentButton" />
    </stripes:layout-component>
</stripes:layout-render>