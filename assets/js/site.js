import Alpine from 'alpinejs';

window.Alpine = Alpine;

function darkModeToggle() {
    return {
        mode: Alpine.store('mode', ''),
        toggleMode() {
            const isDark = this.mode === 'dark';
            this.mode = isDark ? 'light' : 'dark';
            localStorage.setItem('mode', this.mode);
        },
        init() {
            this.mode = localStorage.getItem('mode') || 'light';
        }
    };
}
window.darkModeToggle = darkModeToggle;

function add_anchors(){
    const headings = document.querySelectorAll(
        'main h2[id], main h3[id], main h4[id], main h5[id], main h6[id]');
    headings.forEach((h) => {
        h.innerHTML = '<a href="#'+h.id+'" class="anchor">#</a>' + h.innerHTML;
    });
}
document.addEventListener('DOMContentLoaded', add_anchors);


Alpine.start();
