<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Registros existentes - Proyecto Escolar</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

    <nav class="flex flex-wrap mb-6 text-slate-400 text-sm w-full" aria-label="Breadcrumb">
        <ol class="inline-flex items-center space-x-2">
            <li>
                <a href="${createLink(uri: '/')}" class="hover:text-blue-500 transition-colors flex items-center">
                    <i class="fas fa-home mr-2"></i> Inicio
                </a>
            </li>
            <li><span class="text-slate-600">/</span></li>
            <li class="text-blue-500 font-medium">Registros existentes</li>
        </ol>
    </nav>

    <div class="flex flex-col gap-4 mb-6 w-full">
    
        <div class="flex flex-col md:flex-row justify-between items-end gap-4">
            <h2 class="text-xl font-bold text-white">Registros existentes</h2>
            
            <a href="${createLink(controller: 'main', action: 'index')}" 
               class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg text-sm font-medium shadow-sm transition-colors flex items-center whitespace-nowrap">
                <i class="fas fa-plus mr-1"></i> Nuevo
            </a>
        </div>

        <div class="bg-slate-800 p-4 rounded-lg border border-slate-700 grid grid-cols-1 md:grid-cols-3 gap-4">
            
            <div class="relative">
                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                    <i class="fas fa-user text-slate-500"></i>
                </div>
                <input type="text" id="filtro-nombre" 
                    maxlength="50"
                    autocomplete="off"
                    oninput="this.value = this.value.replace(/[<>/;(){}]/g, '')"
                    class="filtro-input bg-slate-900 border border-slate-600 text-slate-300 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2.5 placeholder-slate-500" 
                    placeholder="Buscar por Nombre...">
            </div>

            <div class="relative">
                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                    <i class="fas fa-phone text-slate-500"></i>
                </div>
                <input type="tel" id="filtro-telefono" 
                    maxlength="15"
                    autocomplete="off"
                    oninput="this.value = this.value.replace(/[^0-9+\- ]/g, '')"
                    class="filtro-input bg-slate-900 border border-slate-600 text-slate-300 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2.5 placeholder-slate-500" 
                    placeholder="Buscar por Teléfono...">
            </div>

            <div class="relative">
                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                    <i class="fas fa-envelope text-slate-500"></i>
                </div>
                <input type="email" id="filtro-correo" 
                    maxlength="60"
                    autocomplete="off"
                    oninput="this.value = this.value.replace(/[<>()'"\s]/g, '')"
                    class="filtro-input bg-slate-900 border border-slate-600 text-slate-300 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2.5 placeholder-slate-500" 
                    placeholder="Buscar por Correo...">
            </div>
        </div>
    </div>

    <div class="w-full max-w-full bg-slate-800 rounded-lg border border-slate-700 overflow-hidden shadow-lg">
        <div class="overflow-x-auto">
            <table class="w-full text-sm text-left text-slate-300 table-fixed md:table-auto">
                <thead class="text-xs text-slate-400 uppercase bg-slate-900/50 border-b border-slate-700">
                    <tr>
                        <th class="px-2 md:px-4 py-3 w-1/4 md:w-1/6">Fecha</th>
                        <th class="px-2 md:px-4 py-3 w-1/2 md:w-auto">Datos</th>
                        <th class="px-2 md:px-4 py-3 w-1/4 md:w-1/6 text-center">Acciones</th>
                    </tr>
                </thead>
                <tbody id="tabla-registros" class="divide-y divide-slate-700">
                    <tr>
                        <td colspan="3" class="px-4 py-12 text-center text-slate-500">
                            <i class="fas fa-spinner fa-spin text-2xl mb-2"></i>
                            <p>Cargando registros...</p>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        // URLs generadas por Grails (Solo aquí usamos GSP tags)
        var URL_LISTA_DATA = "${createLink(controller: 'api', action: 'index')}"; 
        var URL_DELETE = "${createLink(controller: 'api', action: 'delete')}"; 
        var URL_EDIT_PAGE = "${createLink(controller: 'main', action: 'edit')}";

        document.addEventListener("DOMContentLoaded", function() {
            cargarRegistros(); 

            // Listener unificado para los 3 filtros con debounce
            const inputs = document.querySelectorAll('.filtro-input');
            let timeout = null;

            inputs.forEach(input => {
                input.addEventListener('input', function() {
                    clearTimeout(timeout);
                    timeout = setTimeout(function() {
                        cargarRegistros(); 
                    }, 400); 
                });
            });
        });

        function cargarRegistros() {
            var tbody = document.getElementById('tabla-registros');
            
            // Función de limpieza extra por seguridad
            const clean = (str) => str ? str.replace(/[<>&"']/g, '').trim() : '';

            const nombreVal = clean(document.getElementById('filtro-nombre').value);
            const telVal    = clean(document.getElementById('filtro-telefono').value);
            const correoVal = clean(document.getElementById('filtro-correo').value);

            // Construcción de URL con parámetros
            const params = new URLSearchParams();
            if (nombreVal) params.append('nombre', nombreVal);
            if (telVal) params.append('telefono', telVal);
            if (correoVal) params.append('correo', correoVal);

            const urlFinal = URL_LISTA_DATA + '?' + params.toString();

            fetch(urlFinal)
                .then(function(response) { return response.json(); })
                .then(function(data) {
                    tbody.innerHTML = ''; 

                    // Estado vacío
                    if (!data || data.length === 0) {
                        const hayFiltros = nombreVal || telVal || correoVal;
                        const mensaje = hayFiltros 
                            ? 'No se encontraron coincidencias.' 
                            : 'No hay registros guardados.';
                        
                        var htmlVacio = '<tr><td colspan="3" class="px-4 py-12 text-center text-slate-500">' +
                                        '<i class="fas fa-folder-open text-4xl mb-3 text-slate-600"></i>' +
                                        '<p>' + mensaje + '</p></td></tr>';
                        tbody.innerHTML = htmlVacio;
                        return;
                    }

                    // Renderizado de filas
                    data.forEach(function(p) {
                        var fechaObj = new Date(p.fechaRegistro);
                        var fecha = fechaObj.toLocaleDateString('es-ES', {day: '2-digit', month: '2-digit', year: 'numeric'});
                        var hora = fechaObj.toLocaleTimeString('es-ES', {hour: '2-digit', minute: '2-digit'});

                        // FILA RESPONSIVA (Diseño Móvil vs Escritorio)
                        var fila = '<tr class="hover:bg-slate-700/30 transition-colors group">' +
                            
                            // 1. FECHA: Texto más pequeño en móvil
                            '<td class="px-2 md:px-4 py-3 text-blue-400 font-mono text-[10px] md:text-xs align-top">' +
                                fecha + '<br><span class="text-slate-500">' + hora + ' hrs</span>' +
                            '</td>' +
                            
                            // 2. DATOS: Correo con break-all para que no rompa la tabla en móvil
                            '<td class="px-2 md:px-4 py-3 align-top">' +
                                '<div class="font-bold text-white text-sm md:text-base mb-1 truncate">' + p.nombre + '</div>' +
                                '<div class="text-xs text-slate-400 flex flex-col gap-1">' +
                                    '<span class="break-all"><i class="fas fa-envelope mr-1 text-slate-500"></i> ' + p.correo + '</span>' +
                                    '<span class="whitespace-nowrap"><i class="fas fa-phone mr-1 text-slate-500"></i> ' + p.telefono + '</span>' +
                                '</div>' +
                            '</td>' +

                            // 3. ACCIONES: Botones apilados (iconos) en móvil, lado a lado (texto) en PC
                            '<td class="px-2 md:px-4 py-3 align-middle text-center">' +
                                '<div class="flex flex-col md:flex-row items-center justify-center gap-2">' +
                                    
                                    // Botón Editar
                                    '<a href="' + URL_EDIT_PAGE + '?id=' + p.id + '" ' +
                                       'class="w-full md:w-auto text-yellow-500 hover:text-white hover:bg-yellow-600 border border-yellow-600 hover:border-transparent font-medium rounded-lg text-xs px-2 py-1 md:px-3 md:py-2 transition-all flex items-center justify-center">' +
                                       '<i class="fas fa-pen"></i><span class="hidden md:inline ml-1">Editar</span>' +
                                    '</a>' +
                                    
                                    // Botón Borrar
                                    '<button onclick="borrarRegistro(' + p.id + ', this)" ' +
                                       'class="w-full md:w-auto text-red-500 hover:text-white hover:bg-red-600 border border-red-600 hover:border-transparent font-medium rounded-lg text-xs px-2 py-1 md:px-3 md:py-2 transition-all flex items-center justify-center">' +
                                       '<i class="fas fa-trash"></i><span class="hidden md:inline ml-1">Borrar</span>' +
                                    '</button>' +
                                '</div>' +
                            '</td>' +
                        '</tr>';

                        tbody.insertAdjacentHTML('beforeend', fila);
                    });
                })
                .catch(function(error) {
                    console.error('Error:', error);
                    tbody.innerHTML = '<tr><td colspan="3" class="text-center text-red-500 py-4">Error al cargar datos</td></tr>';
                });
        }

        // Función Borrar con SweetAlert2
        function borrarRegistro(id, boton) {
            Swal.fire({
                title: '¿Eliminar registro?',
                text: "No podrás revertir esta acción.",
                icon: 'warning',
                background: '#1e293b', color: '#fff',
                showCancelButton: true,
                confirmButtonColor: '#ef4444', cancelButtonColor: '#334155',
                confirmButtonText: 'Sí, eliminar', cancelButtonText: 'Cancelar'
            }).then(function(result) {
                if (result.isConfirmed) {
                    fetch(URL_DELETE + '?id=' + id, { method: 'POST' })
                    .then(function(response) { return response.json(); })
                    .then(function(data) {
                        if (data.exito) {
                            Swal.fire({
                                toast: true, position: 'top-end', showConfirmButton: false, timer: 3000,
                                icon: 'success', title: data.mensaje, background: '#1e293b', color: '#fff'
                            });
                            var fila = boton.closest('tr');
                            fila.style.opacity = "0";
                            setTimeout(function() { fila.remove(); }, 500);
                        } else {
                            Swal.fire({ icon: 'error', title: 'Error', text: data.mensaje, background: '#1e293b', color: '#fff' });
                        }
                    })
                    .catch(function(e) { Swal.fire('Error', 'Error de conexión', 'error'); });
                }
            });
        }
    </script>

</body>
</html>