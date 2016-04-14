<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form id="add-interview-form" class="hide col s12" method="POST" action="<c:url value="/interview/form"/>">
    <input type="hidden" name="type" value="${interview.type.id}"/>

    <div class="row valign-wrapper">
        <div class="col l9 m9 left-align">
            <h4 id="title">Редактирование анкеты</h4>
        </div>
        <div class="col l3 m3">
            <i class="interview-icon medium material-icons teal-text right">${interview.type.visibilityIcon}</i>
        </div>
    </div>

    <div class="row">
        <div class="input-field col s12">
            <input value="${interview.name}" required name="name" class="validate" type="text"
                   placeholder="Минимум 5 символов"
                   pattern=".{5,}" length="60"/>
            <label class="active">Наименование</label>
        </div>

        <c:if test="${interview.type.name eq 'open'}">
            <div class="input-field col s12 m6 l6">
                <select required id="subdivisions" name="subdivisions" class="validate" multiple>
                    <option value="-1" disabled selected>Выберите подразделения</option>
                    <c:forEach var="entry" items="${subdivisions}">
                        <c:choose>
                            <c:when test="${entry.value eq 'selected'}">
                                <option selected value="${entry.key.id}">${entry.key.name}</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${entry.key.id}">${entry.key.name}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
                <label for="subdivisions">Подразделение</label>
            </div>

            <div class="input-field col s12 m6 l6">
                <select required id="posts" class="validate" multiple>
                    <c:forEach var="entry" items="${posts}">
                        <c:choose>
                            <c:when test="${entry.value eq 'selected'}">
                                <option selected value="${entry.key.id}">${entry.key.name}</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${entry.key.id}">${entry.key.name}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
                <label for="posts">Должности</label>
            </div>
        </c:if>

        <c:if test="${interview.type.name eq 'close'}">
            <div class="input-field col s12 m6 l6">
                <input required value="${interview.goal}" id='goal' class='validate' type='text' length='65'
                       placeholder='Максимум 65 символов'/>
                <label class="active">Цель опроса</label>
            </div>
            <div class="input-field col s12 m6 l6">
                <input required value="${interview.audience}" id='audience' class='validate' type='text' length='25'
                       placeholder='Максимум 25 символов'/>
                <label class="active">Целевая аудитория</label>
            </div>
        </c:if>

        <div class="input-field col s12 m12 l4">
            <input value="${interview.formatEndDate}" required id="end-date" name="end-date" class="datepicker"
                   type="date"
                   pattern="[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"/>
            <label for="end-date">Дата окончания опроса</label>
        </div>

        <div class="input-field col s12 m12 l8">
            <input value="${interview.description}" required name="description" class="validate" type="text"
                   placeholder="Минимум 3 символа" pattern=".{3,}"
                   length="70"/>
            <label class="active">Описание</label>
        </div>
    </div>

    <div class="row valign-wrapper">
        <div class="col s1 left-align hide-on-small-only">
            <a id="go-back" href="<c:url value="/editor/interview-list"/>"><i
                    class="medium material-icons brown-text text-lighten-2" title="Назад">reply</i></a>
        </div>
        <div class="col s11 right-align">
            <a href="<c:url value="/editor/interview-list"/>" class="waves-effect waves-light btn-large red accent-2">Отмена</a>
            <a id="submit" class="waves-effect waves-light btn-large accent-2"><i
                    class="material-icons right">send</i>Продолжить</a>
        </div>
    </div>
</form>
