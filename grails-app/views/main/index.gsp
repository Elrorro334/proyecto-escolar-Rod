<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Registro - Rodnix</title>
</head>
<body>

    <h1>Hola Mundo</h1>
    <p>Ingresa tu nombre</p>

    <g:form controller="main" action="save" method="POST" class="rodnix-form">
        <div class="input-group">
            <label for="nombre">Nombre Completo</label>
            <input type="text" id="nombre" name="nombre" class="form-control" value="${nombre}" placeholder="Ej. Rodrigo Sánchez" required>
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

        <a href="${createLink(controller: 'main', action: 'lista')}" style="display:block; margin-top:15px; text-align:center; color:#fff;">
            Ver lista existente
        </a>
    </g:form>

    <script>
        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
            background: '#1a1c23',
            color: '#ffffff'
        });

        <g:if test="${flash.error || error}">
            Toast.fire({
                icon: 'error',
                title: '${flash.error ?: error}'
            });
        </g:if>
    </script>

</body>
</html>