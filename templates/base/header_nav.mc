<div class="header" x-data="{ isOpen: false }">

  <nav class="row${ ' '+site.header_css_class if site.header_css_class else ''}" aria-label="Project Navigation">
    % if site.logo:
      <a class="logo-link" href="${ site.leading_path or ''}/">
        % if site.logo.image:
          <img class="logo ${'logo-light' if site.logo.image_dark else 'nav-links' }" src="${ site.logo.image }" alt="${ site.logo.heading or site.project_name or '' } - Logo" decoding="async">
            % if site.logo.image_dark:
              <img class="logo logo-dark" src="${ site.logo.image_dark }" alt="${ site.logo.heading or site.project_name or '' } - Logo" decoding="async">
            % endif
        % endif
        <span class="logo-heading">${ site.logo.heading or site.project_name }</span>
      </a>
    % else:
      <a class="logo-link fallback" href="${ site.leading_path or '' }/"><span class="logo-heading">${ site.project_name or '??' }</span></a>
    % endif
    <div class="nav-content">
      <ul>
        % for link in site.topnav_links:
          <li>
            <a ${ 'target="_blank"' if link.icon else '' } href="${ link.url | url }">
              ${ link.label or ('' if link.icon else '??') }
              % if link.icon:
                <img class="nav-links" src="${ link.icon }" alt="${ link.alt or link.label or '' |h }" width="32" height="32" decoding="async">
              % endif
            </a>
          </li>
        % endfor
      </ul>
      <div class="dark-mode-toggle">
        <button id="js-dark-mode" class="theme-btn" aria-label="dark mode toggle" @click="toggleMode()">
          <%include file="svg/darklightmode.svg" />
        </button>
      </div>
      <div class="ham">
        <button :aria-expanded="isOpen"
          aria-controls="docnav-inner docnav-inner-mobile"
          @click="isOpen = !isOpen" x-cloak>
          <p>${ site.main_nav.title or 'Home' } Menu</p>
          <span></span>
        </button>
      </div>
    </div>
  </nav>

  <nav class="docnav-mob"
      aria-label="${ site.main_nav.title or 'Home' } Navigation"
      :aria-expanded="isOpen">
    <div id="docnav-inner-mobile" class="docnav-inner" :hidden="!isOpen" x-cloak>
      <%include file="docnav_list.mc" />
     </div>
  </nav>

</div>
