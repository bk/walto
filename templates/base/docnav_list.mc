<%!
  def _urlnorm(s):
      if not isinstance(s, str):
          return s
      else:
          return s.replace('/index.html', '/')
%>\
<ol class="docnav-list">
  <li class="${ 'active' if _urlnorm(SELF_URL) == '/' else '' }">
    <a href="${ site.leading_path or '' }/">${ site.home_title or 'Home' }</a>
  </li>
  ## NOTE that this nav is only meant to handle `nav: auto` in
  ## wmk_config.yaml, not a custom `nav` with more than one level of
  ## nesting.
  % for nav_item in nav:
    % if nav_item.children:
      ## Section with its links
      % if site.main_nav.sections_collapsible:
        <% active_within = [1 for _ in nav_item if _urlnorm(SELF_URL) == _urlnorm(_.url)] %>
        <details class="docnav-details"${ ' open' if active_within else ''}>
          <summary class="docnav-title">${ nav_item.title }</summary>
            <ol class="docnav-list">
            % for it in nav_item:
              <li class="${ 'active' if _urlnorm(SELF_URL) == _urlnorm(it.url) else '' }">
                <a href="${ it.url }">${ it.title }</a>
              </li>
            % endfor
            </ol>
        </details>
      % else:
        <li>
          <p class="docnav-title">${ nav_item.title }</p>
          <ol class="docnav-list">
            % for it in nav_item:
              <li class="${ 'active' if _urlnorm(SELF_URL) == _urlnorm(it.url) else '' }">
                <a href="${ it.url }">${ it.title }</a>
              </li>
            % endfor
          </ol>
        </li>
      % endif
    % else:
      ## "Root" section links; appear at the top without a section marker
      <li class="${ 'active' if _urlnorm(SELF_URL) == _urlnorm(nav_item.url) else '' }">
        <a href="${ nav_item.url }">${ nav_item.title }</a>
      </li>
    % endif
  % endfor
</ol>
