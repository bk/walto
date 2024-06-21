% if site.banner and site.banner.enable and site.banner.html:
  <header class="banner"
    x-cloak
    x-data="{
        hidden: true,
        show_until: new Date('${ site.banner.show_until or "2999-12-31T23:59:59Z" }').getTime(),
        hide_if: 'banner_${ site.banner.id or "walto-banner" }',
    }"
    x-show="!hidden"
    x-init="
        hidden = localStorage.getItem(hide_if)
            || ((show_until - Date.now()) < 0)
            || false;
    ">
    <p>${ site.banner.html }</p>
    <button @click="
        localStorage.setItem(hide_if, 'true');
        hidden = true;
    ">${ site.banner.close_label or 'Close' }</button>
  </header>
% endif
