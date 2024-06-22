% if nav and page:
  ${ _prevnext() }
% endif

<%def name="_prevnext()">
<%
    links = nav._links_in_order()
    nav_prev = None
    nav_next = None
    linkcount = len(links)
    for i, x in enumerate(links):
        if cleanurl(x.url) == cleanurl(SELF_URL):
            if i > 0:
                nav_prev = links[i-1]
            if i < linkcount - 1:
                nav_next = links[i+1]
            break
    if not (nav_prev or nav_next):
        return ''
%>
<div class="prevnext" data-pagefind-ignore>
  % if nav_prev:
    <span class="prev"><a href="${ nav_prev.url }">« ${ nav_prev.title }</a></span>
  % endif
  % if nav_prev and nav_next:
    <span class="sep">|</span>
  % endif
  % if nav_next:
    <span class="next"><a href="${ nav_next.url }">${ nav_next.title } »</a></span>
  % endif
</div>
</%def>
