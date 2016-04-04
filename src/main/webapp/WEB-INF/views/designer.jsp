<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="fragments/meta.html" %>
    <%@include file="fragments/general-css.html" %>
    <link href="<c:url value="/resources/css/designer.css"/>" rel="stylesheet" type="text/css">
    <title>Interview Street - Редактор анкет</title>
</head>
<body>
<%@include file="fragments/header.jsp" %>
<main class="container">
    <div class="row">

        <div class="col l12 m12 s12">
            <h4 class="header teal-text">${interview.name}</h4>
            <h5 class="interview-type">${interview.type.rusName}</h5>

            <!--Icon bar-->
            <div class="row icons-row">
                <div class="col l12 m12 s12">

                    <i id="clipboard-btn" class="small material-icons light-blue-text text-accent-3"
                       data-clipboard-target=".interview-url" title="Копировать адрес ссылки">settings_ethernet</i>
                    <i class="small material-icons orange-text text-accent-4" title="Список респондентов">supervisor_account</i>
                    <i class="small material-icons green-text text-accent-4" title="Анализ результатов">equalizer</i>
                    <i class="small material-icons blue-grey-text text-lighten-2" title="Предварительный просмотр">pageview</i>
                    <i class="small material-icons brown-text text-lighten-1" title="Распечатать анкету">print</i>
                </div>
            </div>

            <!--Interview initial text-->
            <div class="row narrow-row">
                <div class="input-field col l12 m12 s12">
                    <input
                            value="Здравствуйте, потратьте, пожалуйста, несколько минут своего времени на заполнение следующей анкеты."
                            id="initial-text" type="text" length="200"/>
                    <label class="active" for="initial-text">Вводный текст анкеты</label>
                </div>
            </div>
        </div>

        <!--This is container for forms-->
        <div id="question-container" class="col offset-l1 offset-m1 l10 m10 s12 center">
            <a class="btn-floating btn-large add-quest-btn first-btn waves-effect waves-light blue-grey lighten-2 hoverable"
               title="Добавить вопрос"><i class="material-icons">add</i></a>

            <c:forEach var="question" items="${questions}" varStatus="item">
                <c:set var="answerType" scope="page" value="${question.answers[0].type}"/>

                <div class="section" data-question="${question.id}">

                        <%--Navigation--%>
                    <div class="row">
                        <div class="col l12 m12 s12">
                            <nav>
                                <div class="left number">${item.index + 1}</div>
                                <ul>
                                    <li><a><i class="material-icons move-down"
                                              title="Переместить вниз">arrow_downward</i></a></li>
                                    <li><a><i class="material-icons move-up" title="Переместить вверх">arrow_upward</i></a>
                                    </li>
                                    <li><a><i class="material-icons duplicate"
                                              title="Дублировать вопрос">control_point_duplicate</i></a></li>
                                    <li><a><i class="material-icons del-quest" title="Удалить вопрос">delete</i></a>
                                    </li>
                                </ul>
                                <i class="right material-icons teal-text text-lighten-2"
                                   title="${answerType.title}">${answerType.icon}</i>
                            </nav>
                        </div>
                    </div>

                        <%--Body--%>
                    <div class="row narrow-row">
                        <div class="input-field col l12 m12 s12">
                            <input value="Введите текст вопроса" type="text" length="250"
                                   title="Текст вопроса"/>
                            <label class="active">Текст вопроса</label>
                        </div>

                        <c:choose>
                            <c:when test="${answerType.name eq 'radio' || answerType.name eq 'checkbox'}">
                                <c:forEach var="answer" items="${question.answers}">
                                    <div class="row narrow-row" data-answer="${answer.id}">
                                        <div class="input-field  col offset-l2 l7 m11 s11">
                                            <input type="text" length="100"
                                                   value="${answer.text}" title="Текст ответа"/>
                                            <label class="active">Введите ответ</label>
                                        </div>
                                        <div class="col icon-col l1 m1 s1">
                                            <i class="del-answer small material-icons red-text text-lighten-1"
                                               title="Удалить ответ">delete_forever</i>
                                        </div>
                                    </div>
                                </c:forEach>
                                <div class="col wide-col offset-l2 l8 left-align">
                                    <i class="add-answer small material-icons green-text text-accent-4"
                                       title="Добавить ответ">add</i>
                                    <i class="add-text-answer small material-icons deep-orange-text"
                                       title="Добавить текстовый ответ">playlist_add</i>
                                </div>
                            </c:when>
                            <c:when test="${answerType.name eq 'rating'}">
                                <div class="input-field col offset-l2 l8 m12 s12">
                                    <input type="number" min="3" max="10"
                                           value="${answerType.defaultValue}" title="Количество звезд"/>
                                    <label class="active">Количество звезд</label>
                                </div>
                                <div class="col offset-l2 col l8 m12 s12 rating center">
                                    <c:forEach begin="1" end="${answerType.defaultValue}">
                                        <i class="small material-icons red-text text-lighten-1 hoverable">star_rate</i>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="input-field  col offset-l2 l8 m11 s11">
                                    <input disabled type="text" length="100"
                                           title="Для данного типа вопроса не требуется ответ"/>
                                    <label>Не содержит ответов</label>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                        <%--Footer--%>
                    <div class="divider grey lighten-1"></div>

                    <a class="btn-floating btn-large add-quest-btn waves-effect waves-light blue-grey lighten-2 hoverable"
                       title="Добавить вопрос"><i class="material-icons">add</i></a>
                </div>
            </c:forEach>

        </div>
    </div>

    <!--Hidden input for clipboard-->
    <label>
        <input type="text" class="interview-url" value="/test/url/place/here2d"/>
    </label>
</main>

<%@include file="fragments/footer.jsp" %>

<%@include file="fragments/templates/answers/disabled-answer-template.jsp" %>
<%@include file="fragments/templates/answers/text-answer-tamplate.jsp" %>
<%@include file="fragments/templates/answers/rate-answer-template.jsp" %>
<%@include file="fragments/templates/answers/multi-answer-template.jsp" %>
<%@include file="fragments/templates/question-template.jsp" %>
<%@include file="fragments/templates/stag-list-template.jsp" %>

<%@include file="fragments/general-js.html" %>
<script src="<c:url value="/resources/vendors/clipboard/clipboard.js"/>"></script>
<script src="<c:url value="/resources/vendors/js-render/jsrender.js"/>"></script>
<script src="/resources/js/designer.js"></script>

</body>
</html>
