$(document).ready(function () {
    var multipleCardCarouselDamas = document.querySelector("#carouselDamas");
    var multipleCardCarouselCaballeros = document.querySelector("#carouselCaballeros");

    if (window.matchMedia("(min-width: 576px)").matches) {
        var carouselDamas = new bootstrap.Carousel(multipleCardCarouselDamas, {
            interval: false,
            wrap: false
        });
        var carouselCaballeros = new bootstrap.Carousel(multipleCardCarouselCaballeros, {
            interval: false,
            wrap: false
        });

        var carouselWidthDamas = $(".carousel-inner", multipleCardCarouselDamas)[0].scrollWidth;
        var cardWidthDamas = $(".carousel-item", multipleCardCarouselDamas).width();
        var scrollPositionDamas = 0;

        var carouselWidthCaballeros = $(".carousel-inner", multipleCardCarouselCaballeros)[0].scrollWidth;
        var cardWidthCaballeros = $(".carousel-item", multipleCardCarouselCaballeros).width();
        var scrollPositionCaballeros = 0;

        $("#carouselDamas .carousel-control-next").on("click", function () {
            if (scrollPositionDamas < carouselWidthDamas - cardWidthDamas * 3) {
                scrollPositionDamas += cardWidthDamas;
                $("#carouselDamas .carousel-inner").animate(
                    { scrollLeft: scrollPositionDamas },
                    600
                );
            }
        });
        $("#carouselDamas .carousel-control-prev").on("click", function () {
            if (scrollPositionDamas > 1) {
                scrollPositionDamas -= cardWidthDamas;
                $("#carouselDamas .carousel-inner").animate(
                    { scrollLeft: scrollPositionDamas },
                    600
                );
            }
        });

        $("#carouselCaballeros .carousel-control-next").on("click", function () {
            if (scrollPositionCaballeros < carouselWidthCaballeros - cardWidthCaballeros * 3) {
                scrollPositionCaballeros += cardWidthCaballeros;
                $("#carouselCaballeros .carousel-inner").animate(
                    { scrollLeft: scrollPositionCaballeros },
                    600
                );
            }
        });
        $("#carouselCaballeros .carousel-control-prev").on("click", function () {
            if (scrollPositionCaballeros > 1) {
                scrollPositionCaballeros -= cardWidthCaballeros;
                $("#carouselCaballeros .carousel-inner").animate(
                    { scrollLeft: scrollPositionCaballeros },
                    600
                );
            }
        });
    } else {
        $(multipleCardCarouselDamas).addClass("slide");
        $(multipleCardCarouselCaballeros).addClass("slide");
    }
});

/* insertar*/
// Agrega un evento clic al botón "Agregar" dentro del modal para manejar la inserción de la zapatilla
document.getElementById("addProductButton").addEventListener("click", function () {
    // Obtén los datos del formulario
    const productName = document.getElementById("productName").value;
    const productPrice = document.getElementById("productPrice").value;
    const productImageFile = document.getElementById("productImage").files[0];

    // Verificar si se seleccionó un archivo de imagen
    if (productImageFile) {
        // Crear una URL para la imagen seleccionada
        const productImageURL = URL.createObjectURL(productImageFile);

        // Crear una nueva tarjeta de zapatilla
        const newProductCard = `
            <div class="col-sm-6 mb-3 mb-sm-0">
                <div class="card">
                    <div class="card-body">
                        <img src="${productImageURL}" class="card-img-top" alt="...">
                        <h5 class="card-title">${productName}</h5>
                        <p>$${productPrice}</p>
                        <p class="card-text"></p>
                        <a href="#" class="btn btn-primary">ver detalles</a>
                    </div>
                </div>
            </div>
        `;

        // Agregar la nueva tarjeta de zapatilla a la lista existente
        const productList = document.querySelector(".row");
        productList.innerHTML += newProductCard;

        // Limpiar el formulario después de agregar la zapatilla
        document.getElementById("newProductForm").reset();

        // Cierra el modal
        const modal = new bootstrap.Modal(document.getElementById("addProductModal"));
        modal.hide();
    } else {
        alert("Por favor, seleccione una imagen de zapatilla.");
    }
});

