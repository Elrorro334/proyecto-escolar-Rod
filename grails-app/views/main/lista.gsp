<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Lista - Rodnix</title>
</head>
<body>

    <div class="list-container">
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
            <h2>Registros en BD</h2>
            <a href="${createLink(controller: 'main', action: 'index')}" class="btn-submit" style="text-decoration:none; padding:8px 15px;">
                <i class="fas fa-plus"></i> Nuevo
            </a>
        </div>
        
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
        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
            background: '#1a1c23', 
            color: '#ffffff',      
            didOpen: (toast) => {
                toast.addEventListener('mouseenter', Swal.stopTimer)
                toast.addEventListener('mouseleave', Swal.resumeTimer)
            }
        });

        <g:if test="${flash.message}">
            Toast.fire({
                icon: 'success',
                title: '${flash.message}'
            });
        </g:if>
    </script>

</body>
</html>