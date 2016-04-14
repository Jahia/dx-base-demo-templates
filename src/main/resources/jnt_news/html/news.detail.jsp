<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>

<template:addResources type="css" resources="news.css"/>
<template:addResources type="javascript" resources="owl.carousel.js"/>
<template:addResources type="javascript" resources="owl-carousel.js"/>
<template:addResources type="css" resources="owl.carousel.css"/>

<%-- photoswipe files --%>
<template:addResources type="css" resources="plugins/photoswipe/photoswipe.css"/>
<template:addResources type="css" resources="plugins/photoswipe/default-skin/default-skin.css"/>
<template:addResources type="javascript" resources="plugins/photoswipe/photoswipe.min.js"/>
<template:addResources type="javascript" resources="plugins/photoswipe/photoswipe-ui-default.min.js"/>
<template:addResources type="javascript" resources="custom/news.js"/>


<c:set var="language" value="${currentResource.locale.language}"/>
<fmt:setLocale value="${language}" scope="session"/>

<c:set var="newsImage" value="${currentNode.properties['image'].node}"/>
<c:set var="newsTitle" value="${currentNode.properties['jcr:title']}"/>
<c:set var="description" value="${currentNode.properties['desc']}"/>
<c:set var="galleryImgs" value="${currentNode.properties['galleryImg']}"/>
<fmt:formatDate pattern="MMMM dd, yyyy" dateStyle="short" value="${currentNode.properties['date'].time}"
                var="newsDate"/>


<!-- News Detail -->

<!-- News v3 -->
<div class="news-v3 margin-bottom-30">
    <h2>${newsTitle.string}</h2>

    <div id="sync1" class="owl-carousel newsPicture">
        <c:if test="${not empty newsImage}">

            <div class="item">
                    <%-- if there is a gallery format for the photoswipe otherwise just display image --%>
                <c:choose>
                    <c:when test="${not empty galleryImgs}">
                        <a href="${newsImage.url}"
                           data-size="${newsImage.properties['j:width'].string}x${newsImage.properties['j:height'].string}">
                            <img class="img-responsive full-width" src="${newsImage.url}"
                                 height="${newsImage.properties['j:height'].string}"
                                 width="${newsImage.properties['j:width'].string}"/>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <img class="img-responsive full-width" src="${newsImage.url}"
                             height="${newsImage.properties['j:height'].string}"
                             width="${newsImage.properties['j:width'].string}"/>
                    </c:otherwise>
                </c:choose>
            </div>


        </c:if>
        <c:if test="${not empty galleryImgs}">
            <c:forEach var="galleryImg" items="${galleryImgs}" varStatus="status">

                <div class="item">
                    <a href="${galleryImg.node.url}"
                       data-size="${galleryImg.node.properties['j:width'].string}x${galleryImg.node.properties['j:height'].string}"><img
                            class="img-responsive full-width" src="${galleryImg.node.url}"
                            height="${galleryImg.node.properties['j:height'].string}"
                            width="${galleryImg.node.properties['j:height'].string}"/></a>
                </div>

            </c:forEach>
        </c:if>
    </div>

    <%-- create thumbnails of news image and gallery images --%>
    <c:if test="${not empty galleryImgs}">
        <div id="sync2" class="owl-carousel owl-theme">

            <c:if test="${not empty newsImage}">
                <div class="item"><img class="img-responsive full-width" src="${newsImage.url}?t=thumbnail2"/></div>
            </c:if>
            <c:if test="${not empty galleryImgs}">
                <c:forEach var="galleryImg" items="${galleryImgs}" varStatus="status">
                    <div class="item">
                        <img src="${galleryImg.node.url}?t=thumbnail2"/>
                    </div>
                </c:forEach>
            </c:if>
        </div>
    </c:if>
    <div class="news-v3-in">
        <template:include view="hidden.tagListView"/>
    ${description.string}
    </div>

</div>

<%-- set up the back navigation --%>
<c:set var="parentUrl">javascript:history.back()</c:set>
<p>
    <a href="${parentUrl}" class="button button-mini button-border button-rounded"><span><i
            class="icon-line-arrow-left"></i><fmt:message key="jdnt_news.back"/></span></a>
</p>

<%-- photoswipe setup --%>
<%-- Root element of PhotoSwipe. Must have class pswp. DO NOT CHANGE --%>
<div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">

    <!-- Background of PhotoSwipe.
         It's a separate element, as animating opacity is faster than rgba(). -->
    <div class="pswp__bg"></div>

    <!-- Slides wrapper with overflow:hidden. -->
    <div class="pswp__scroll-wrap">

        <!-- Container that holds slides. PhotoSwipe keeps only 3 slides in DOM to save memory. -->
        <!-- don't modify these 3 pswp__item elements, data is added later on. -->
        <div class="pswp__container">
            <div class="pswp__item"></div>
            <div class="pswp__item"></div>
            <div class="pswp__item"></div>
        </div>

        <!-- Default (PhotoSwipeUI_Default) interface on top of sliding area. Can be changed. -->
        <div class="pswp__ui pswp__ui--hidden">

            <div class="pswp__top-bar">

                <!--  Controls are self-explanatory. Order can be changed. -->

                <div class="pswp__counter"></div>

                <button class="pswp__button pswp__button--close" title="Close (Esc)"></button>

                <button class="pswp__button pswp__button--share" title="Share"></button>

                <button class="pswp__button pswp__button--fs" title="Toggle fullscreen"></button>

                <button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>

                <!-- Preloader demo http://codepen.io/dimsemenov/pen/yyBWoR -->
                <!-- element will get class pswp__preloader--active when preloader is running -->
                <div class="pswp__preloader">
                    <div class="pswp__preloader__icn">
                        <div class="pswp__preloader__cut">
                            <div class="pswp__preloader__donut"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
                <div class="pswp__share-tooltip"></div>
            </div>

            <button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)">
            </button>

            <button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)">
            </button>

            <div class="pswp__caption">
                <div class="pswp__caption__center"></div>
            </div>

        </div>

    </div>

</div>
<%-- end photoswipe setup --%>
