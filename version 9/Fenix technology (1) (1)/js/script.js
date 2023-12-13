let menu = document.querySelector('#menu-icon');
let navlist = document.querySelector('.navlist');

menu.onclick = () => {
    menu.classList.toggle('bx-x');
    navlist.classList.toggle('open');
};
window.onscroll = () => {
    menu.classList.remove('bx-x');
    navlist.classList.remove('open');
};
const sr = ScrollReveal ({
    distance: '60px',
    duration: 4000,
    delay: 400,
});
sr.reveal('.secciones-text',{delay:200, origin:'top'});
sr.reveal('.secciones-img',{delay:450, origin:'top'});
sr.reveal('.icons',{delay:500, origin:'left'});
sr.reveal('.home-text',{delay:200, origin:'top'});
sr.reveal('.home-img',{delay:300, origin:'top'});
sr.reveal('.feature, .product, .cta-content, .contact',{delay:200, origin:'left'});
sr.reveal('.scroll-down',{delay:300, origin:'right'});

const header = document.querySelector("header");
window.addEventListener("scroll", function(){
    header.classList.toggle ("sticky", window.scrollY > 0);
});
window.onscroll = function(){
    if(document.documentElement.scrollTop > 1000){
        document.querySelector('.scroll-down-container')
        .classList.add('show');
    }else{
        document.querySelector('.scroll-down-container')
        .classList.remove('show');
    }
}
document.querySelector('.scroll-down-container')
  .addEventListener('click', () => {
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  });
