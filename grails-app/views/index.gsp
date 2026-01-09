<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Hola mundo - Grails | Rodnix</title>
</head>
<body>

    <h1>Hola Mundo</h1>
    <p>Ingresa tu nombre</p>

    <form action="/save" method="POST" class="rodnix-form">
        <div class="input-group">
            <label for="nombre">Nombre Completo</label>
            <input type="text" id="nombre" name="nombre" class="form-control" placeholder="Ej. Rodrigo Sánchez" required>
        </div>

        <div class="captcha-wrapper">
            <div class="g-recaptcha" 
                 data-sitekey="6LcxNUMsAAAAAJCF18aZ7IRp8F_FEbDCAr-rgChp" 
                 data-theme="dark">
            </div>
        </div>

        <button type="submit" class="btn-submit">
            <i class="fas fa-database"></i> Guardar en BD
        </button>
    </form>

    <div class="list-container">
        <h2>Registros en BD</h2>
        
        <g:if test="${prospectos}">
            <table class="rodnix-table">
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Nombre Registrado</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${prospectos}" var="p">
                        <tr>
                            <td><g:formatDate date="${p.fechaRegistro}" format="dd/MM HH:mm"/></td>
                            <td>${p.nombre}</td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </g:if>
        <g:else>
            <p class="no-data">No hay datos registrados aún.</p>
        </g:else>
    </div>

    <script>
        // Configuración del diseño del Toast (Oscuro y elegante)
        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
            background: '#1a1c23', // Tu color de fondo input
            color: '#ffffff',      // Texto blanco
            didOpen: (toast) => {
                toast.addEventListener('mouseenter', Swal.stopTimer)
                toast.addEventListener('mouseleave', Swal.resumeTimer)
            }
        });

        // Lógica de Grails inyectada en JS
        // Si el servidor mandó un mensaje de éxito (flash.message)
        <g:if test="${flash.message}">
            Toast.fire({
                icon: 'success',
                title: '${flash.message}'
            });
        </g:if>

        // Si el servidor mandó un error (model.error)
        <g:if test="${error}">
            Toast.fire({
                icon: 'error',
                title: '${error}'
            });
        </g:if>
    </script>

</body>
</html>