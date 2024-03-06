const openMenu = document.querySelector("#open-menu");
const closeMenu = document.querySelector("#close-menu");
const aside = document.querySelector("aside");

openMenu.addEventListener("click", () => {
    aside.classList.add("aside-visible");
})

closeMenu.addEventListener("click", () => {
    aside.classList.remove("aside-visible");
})

// JavaScript de los desplegables de los cuatro géneros

const damasButton = document.getElementById('damas');
const submenu1 = document.querySelector('.submenu1');

damasButton.addEventListener('click', () => {
    if (submenu1.style.display === 'block') {
        submenu1.style.display = 'none';
    } else {
        submenu1.style.display = 'block';
    }
});

const caballerosButton = document.getElementById('caballeros');
const submenu2 = document.querySelector('.submenu2');

caballerosButton.addEventListener('click', () => {
    if (submenu2.style.display === 'block') {
        submenu2.style.display = 'none';
    } else {
        submenu2.style.display = 'block';
    }
});

const niñosButton = document.getElementById('niños');
const submenu3 = document.querySelector('.submenu3'); // Cambiado de submenu1 a submenu3

niñosButton.addEventListener('click', () => {
    if (submenu3.style.display === 'block') {
        submenu3.style.display = 'none';
    } else {
        submenu3.style.display = 'block';
    }
});

const niñasButton = document.getElementById('niñas');
const submenu4 = document.querySelector('.submenu4');

niñasButton.addEventListener('click', () => {
    if (submenu4.style.display === 'block') {
        submenu4.style.display = 'none';
    } else {
        submenu4.style.display = 'block';
    }
});

document.addEventListener("DOMContentLoaded", function () {
    const botonesAcciones = document.querySelectorAll(".boton-accion");
    const botonesEditar = document.querySelectorAll(".boton-editar");

    botonesAcciones.forEach((boton) => {
        boton.addEventListener("click", function () {
            const producto = boton.closest(".producto");
            const detalles = producto.querySelector(".producto-detalles");

            if (boton.classList.contains("activo")) {
                boton.textContent = "Activar";
                boton.classList.remove("activo");
                boton.classList.add("inactivo");
                detalles.classList.add("desactivado");
            } else if (boton.classList.contains("inactivo")) {
                boton.textContent = "Desactivar";
                boton.classList.remove("inactivo");
                boton.classList.add("activo");
                detalles.classList.remove("desactivado");
            }
        });
    });

    botonesEditar.forEach((boton) => {
        boton.addEventListener("click", function () {
            const producto = boton.closest(".producto");
            const detalles = producto.querySelector(".producto-detalles");
            const descripcion = detalles.querySelector("p");
            const nuevaDescripcion = prompt("Ingrese la nueva descripción:");
            
            if (nuevaDescripcion !== null) {
                descripcion.textContent = nuevaDescripcion;
            }
        });
    });
});