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

    <div class="flex flex-col md:flex-row justify-between items-center mb-6 w-full gap-4">
        <h2 class="text-xl font-bold text-white">Registros existentes</h2>
        
        <div class="flex w-full md:w-auto gap-3">
            <div class="relative w-full md:w-64">
                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                    <i class="fas fa-search text-slate-500"></i>
                </div>
                <input type="text" id="buscador" 
                       class="bg-slate-800 border border-slate-700 text-slate-300 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2.5 placeholder-slate-500" 
                       placeholder="Buscar nombre, correo...">
            </div>

            <a href="${createLink(controller: 'main', action: 'index')}" 
               class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg text-sm font-medium shadow-sm transition-colors flex items-center whitespace-nowrap">
                <i class="fas fa-plus mr-1"></i> Nuevo
            </a>
        </div>
    </div>

    <div class="w-full max-w-full bg-slate-800 rounded-lg border border-slate-700 overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full text-sm text-left text-slate-300">
                <thead class="text-xs text-slate-400 uppercase bg-slate-900/50 border-b border-slate-700">
                    <tr>
                        <th class="px-4 py-3 whitespace-nowrap w-1/6">Fecha</th>
                        <th class="px-4 py-3">Datos del Prospecto</th>
                        <th class="px-4 py-3 w-1/6 text-center">Acciones</th>
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
        // URLs generadas por Grails
        var URL_LISTA_DATA = "${createLink(controller: 'api', action: 'index')}"; 
        var URL_DELETE = "${createLink(controller: 'api', action: 'delete')}"; 
        var URL_EDIT_PAGE = "${createLink(controller: 'main', action: 'edit')}";

        document.addEventListener("DOMContentLoaded", function() {
            cargarRegistros();

            // --- LISTENER DEL BUSCADOR ---
            var buscador = document.getElementById('buscador');
            var timeout = null;

            buscador.addEventListener('input', function(e) {
                // Pequeño retardo (debounce) para no saturar el servidor mientras escribes
                clearTimeout(timeout);
                timeout = setTimeout(function() {
                    cargarRegistros(e.target.value);
                }, 300);
            });
        });

        // 1. FUNCIÓN READ (Ahora acepta filtro)
        function cargarRegistros(query = '') {
            var tbody = document.getElementById('tabla-registros');
            
            // Construimos la URL, si hay búsqueda agregamos ?q=texto
            var urlFinal = URL_LISTA_DATA;
            if(query.trim() !== '') {
                urlFinal += '?q=' + encodeURIComponent(query);
            }
            
            fetch(urlFinal)
                .then(function(response) { return response.json(); })
                .then(function(data) {
                    tbody.innerHTML = ''; 

                    if (!data || data.length === 0) {
                        var mensaje = query ? 'No se encontraron coincidencias.' : 'No hay registros guardados todavía.';
                        tbody.innerHTML = '<tr><td colspan="3" class="px-4 py-12 text-center text-slate-500">' +
                                          '<i class="fas fa-folder-open text-4xl mb-3 text-slate-600"></i>' +
                                          '<p>' + mensaje + '</p></td></tr>';
                        return;
                    }

                    data.forEach(function(p) {
                        var fechaObj = new Date(p.fechaRegistro);
                        var fecha = fechaObj.toLocaleDateString('es-ES', {day: '2-digit', month: '2-digit', year: 'numeric'});
                        var hora = fechaObj.toLocaleTimeString('es-ES', {hour: '2-digit', minute: '2-digit'});

                        var fila = '<tr class="hover:bg-slate-700/30 transition-colors group">' +
                                   '<td class="px-4 py-3 whitespace-nowrap text-blue-400 font-mono text-xs align-top">' +
                                   fecha + '<br><span class="text-slate-500">' + hora + ' hrs</span></td>' +
                                   
                                   '<td class="px-4 py-3 align-top">' +
                                   '<div class="font-bold text-white text-base mb-1">' + p.nombre + '</div>' +
                                   '<div class="text-xs text-slate-400 flex flex-col gap-1">' +
                                   '<span><i class="fas fa-envelope mr-1 text-slate-500"></i> ' + p.correo + '</span>' +
                                   '<span><i class="fas fa-phone mr-1 text-slate-500"></i> ' + p.telefono + '</span>' +
                                   '</div></td>' +

                                   '<td class="px-4 py-3 align-middle text-center">' +
                                   '<div class="flex items-center justify-center space-x-2">' +
                                   
                                   '<a href="' + URL_EDIT_PAGE + '?id=' + p.id + '" ' +
                                   'class="text-yellow-500 hover:text-white hover:bg-yellow-600 border border-yellow-600 hover:border-transparent font-medium rounded-lg text-xs px-3 py-2 transition-all">' +
                                   'Editar</a>' +
                                   
                                   '<button onclick="borrarRegistro(' + p.id + ', this)" ' +
                                   'class="text-red-500 hover:text-white hover:bg-red-600 border border-red-600 hover:border-transparent font-medium rounded-lg text-xs px-3 py-2 transition-all">' +
                                   'Borrar</button>' +
                                   '</div></td></tr>';
                        
                        tbody.insertAdjacentHTML('beforeend', fila);
                    });
                })
                .catch(function(error) {
                    console.error('Error:', error);
                    tbody.innerHTML = '<tr><td colspan="3" class="text-center text-red-500 py-4">Error al cargar datos</td></tr>';
                });
        }

        // 2. FUNCIÓN DELETE
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
                    var url = URL_DELETE + "?id=" + id;

                    fetch(url, {
                        method: 'POST'
                    })
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