<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Gestión de Registros - Proyecto Escolar</title>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <script>
        if (self !== top) { top.location = self.location; }
    </script>

    <style>
        .modal-transition {
            transition: opacity 0.3s ease-out, transform 0.3s ease-out;
            opacity: 0;
            transform: scale(0.95);
            pointer-events: none;
        }
        .modal-active {
            opacity: 1;
            transform: scale(1);
            pointer-events: auto;
        }
        .backdrop-transition {
            transition: opacity 0.3s ease-out;
            opacity: 0;
            pointer-events: none;
        }
        .backdrop-active {
            opacity: 1;
            pointer-events: auto;
        }
    </style>
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
            <li class="text-blue-500 font-medium">Gestión de Registros</li>
        </ol>
    </nav>

    <div class="flex flex-col gap-4 mb-6 w-full">
        <div class="flex flex-col md:flex-row justify-between items-end gap-4">
            <h2 class="text-2xl font-bold text-white tracking-tight">Gestión de Registros</h2>
            
            <button onclick="abrirModalCrear()" 
               class="bg-blue-600 hover:bg-blue-500 text-white px-5 py-2.5 rounded-xl text-sm font-semibold shadow-lg shadow-blue-900/20 transition-all flex items-center hover:scale-105 active:scale-95">
                <i class="fas fa-plus mr-2"></i> Nuevo Registro
            </button>
        </div>

        <div class="bg-slate-800/50 backdrop-blur-sm p-4 rounded-xl border border-slate-700/50 grid grid-cols-1 md:grid-cols-3 gap-4 shadow-sm">
            <div class="relative group">
                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none text-slate-500 group-focus-within:text-blue-500 transition-colors">
                    <i class="fas fa-user"></i>
                </div>
                <input type="text" id="filtro-nombre" class="filtro-input bg-slate-900/80 border border-slate-700 text-slate-200 text-sm rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent block w-full pl-10 p-2.5 transition-all" placeholder="Buscar nombre...">
            </div>
            <div class="relative group">
                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none text-slate-500 group-focus-within:text-blue-500 transition-colors">
                    <i class="fas fa-phone"></i>
                </div>
                <input type="tel" id="filtro-telefono" class="filtro-input bg-slate-900/80 border border-slate-700 text-slate-200 text-sm rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent block w-full pl-10 p-2.5 transition-all" placeholder="Buscar teléfono...">
            </div>
            <div class="relative group">
                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none text-slate-500 group-focus-within:text-blue-500 transition-colors">
                    <i class="fas fa-envelope"></i>
                </div>
                <input type="email" id="filtro-correo" class="filtro-input bg-slate-900/80 border border-slate-700 text-slate-200 text-sm rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent block w-full pl-10 p-2.5 transition-all" placeholder="Buscar correo...">
            </div>
        </div>
    </div>

    <div class="w-full bg-slate-800 rounded-xl border border-slate-700 overflow-hidden shadow-xl mb-4">
        <div class="overflow-x-auto">
            <table class="w-full text-sm text-left text-slate-300">
                <thead class="text-xs text-slate-400 uppercase bg-slate-900/80 border-b border-slate-700">
                    <tr>
                        <th class="px-4 py-4 w-1/5">Fecha</th>
                        <th class="px-4 py-4">Información</th>
                        <th class="px-4 py-4 w-1/6 text-center">Acciones</th>
                    </tr>
                </thead>
                <tbody id="tabla-registros" class="divide-y divide-slate-700/50">
                    <tr>
                        <td colspan="3" class="px-4 py-8 text-center animate-pulse">
                            <div class="h-2.5 bg-slate-700 rounded-full w-48 mb-4 mx-auto"></div>
                            <div class="h-2 bg-slate-700 rounded-full w-32 mx-auto"></div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        
        <div class="bg-slate-900/50 px-4 py-3 border-t border-slate-700 flex items-center justify-between">
            <span class="text-xs text-slate-500">
                Página <span id="pag-actual" class="text-white font-bold">1</span>
            </span>
            <div class="flex gap-2">
                <button id="btn-prev" onclick="cambiarPagina(-1)" disabled 
                    class="px-3 py-1.5 text-xs font-medium text-slate-300 bg-slate-800 border border-slate-600 rounded hover:bg-slate-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors">
                    <i class="fas fa-chevron-left mr-1"></i> Anterior
                </button>
                <button id="btn-next" onclick="cambiarPagina(1)" 
                    class="px-3 py-1.5 text-xs font-medium text-slate-300 bg-slate-800 border border-slate-600 rounded hover:bg-slate-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors">
                    Siguiente <i class="fas fa-chevron-right ml-1"></i>
                </button>
            </div>
        </div>
    </div>

    <div id="backdrop" class="fixed inset-0 z-40 bg-slate-900/80 backdrop-blur-sm backdrop-transition" onclick="cerrarModal()"></div>
    
    <div id="modalFormulario" class="fixed inset-0 z-50 flex items-center justify-center p-4 modal-transition">
        <div class="relative w-full max-w-lg bg-slate-800 rounded-2xl shadow-2xl border border-slate-700 overflow-hidden transform transition-all">
            
            <div class="bg-gradient-to-r from-slate-900 to-slate-800 px-6 py-4 border-b border-slate-700 flex justify-between items-center">
                <h3 class="text-lg font-bold text-white flex items-center gap-2">
                    <span id="modal-icon" class="text-blue-500"><i class="fas fa-plus-circle"></i></span>
                    <span id="modal-titulo">Nuevo Registro</span>
                </h3>
                <button onclick="cerrarModal()" class="text-slate-400 hover:text-white bg-slate-700/50 hover:bg-red-500/80 rounded-full w-8 h-8 flex items-center justify-center transition-all">
                    <i class="fas fa-times"></i>
                </button>
            </div>

            <div class="px-6 py-6">
                <form id="mainForm" autocomplete="off" class="space-y-5">
                    <input type="hidden" id="formId" name="id">

                    <div class="space-y-1">
                        <label class="text-xs font-semibold text-slate-400 uppercase tracking-wider ml-1">Nombre Completo</label>
                        <div class="relative">
                            <input type="text" id="nombre" name="nombre" maxlength="50" required
                                class="w-full bg-slate-900/50 border border-slate-600 rounded-xl px-4 py-3 text-white placeholder-slate-500 focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all outline-none" 
                                placeholder="Ej. Ana García">
                            <div class="absolute right-3 top-3.5 text-slate-500"><i class="fas fa-user"></i></div>
                        </div>
                        <p id="error-nombre" class="text-xs text-red-400 hidden ml-1"><i class="fas fa-exclamation-circle"></i> Mínimo 3 caracteres</p>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div class="space-y-1">
                            <label class="text-xs font-semibold text-slate-400 uppercase tracking-wider ml-1">Teléfono</label>
                            <input type="tel" id="telefono" name="telefono" maxlength="11" required
                                class="w-full bg-slate-900/50 border border-slate-600 rounded-xl px-4 py-3 text-white placeholder-slate-500 focus:ring-2 focus:ring-blue-500 outline-none" 
                                placeholder="55 1234 5678">
                            <p id="error-telefono" class="text-xs text-red-400 hidden ml-1">Mínimo 10 dígitos</p>
                        </div>

                        <div class="space-y-1">
                            <label class="text-xs font-semibold text-slate-400 uppercase tracking-wider ml-1">Correo</label>
                            <input type="email" id="correo" name="correo" maxlength="60" required
                                class="w-full bg-slate-900/50 border border-slate-600 rounded-xl px-4 py-3 text-white placeholder-slate-500 focus:ring-2 focus:ring-blue-500 outline-none" 
                                placeholder="mail@ejemplo.com">
                        </div>
                    </div>

                    <div id="container-captcha" class="flex justify-center pt-2">
                        <div class="g-recaptcha scale-90" data-sitekey="6LcxNUMsAAAAAJCF18aZ7IRp8F_FEbDCAr-rgChp" data-theme="dark"></div>
                    </div>
                    <div id="error-captcha" class="text-center text-xs text-red-400 hidden">Verifica el Captcha</div>
                </form>
            </div>

            <div class="bg-slate-900/50 px-6 py-4 border-t border-slate-700 flex justify-end gap-3">
                <button type="button" onclick="cerrarModal()" 
                    class="px-4 py-2 text-sm font-medium text-slate-300 bg-transparent hover:bg-slate-700 rounded-lg transition-colors">
                    Cancelar
                </button>
                <button type="button" id="btnGuardar" onclick="guardarDatos()" 
                    class="px-6 py-2 text-sm font-medium text-white bg-gradient-to-r from-blue-600 to-blue-500 hover:from-blue-500 hover:to-blue-400 rounded-lg shadow-lg shadow-blue-500/20 transition-all transform hover:scale-105 disabled:opacity-50 disabled:scale-100 flex items-center gap-2">
                    <span id="btnLoader" class="hidden"><i class="fas fa-spinner fa-spin"></i></span>
                    <span id="btnText">Guardar Registro</span>
                </button>
            </div>
        </div>
    </div>

    <script>
        // URLs Grails (Generadas en servidor)
        var API = {
            LIST:   "${createLink(controller: 'api', action: 'index')}",
            SAVE:   "${createLink(controller: 'api', action: 'save')}",
            UPDATE: "${createLink(controller: 'api', action: 'update')}",
            DELETE: "${createLink(controller: 'api', action: 'delete')}",
            SHOW:   "${createLink(controller: 'api', action: 'show')}"
        };

        // Estado
        var pagina = 0;
        var MAX_PER_PAGE = 5;
        var modoActual = 'create';

        document.addEventListener("DOMContentLoaded", function() {
            cargarRegistros();
            
            // Listeners Filtros
            var inputs = document.querySelectorAll('.filtro-input');
            var timeout = null;
            inputs.forEach(function(input) {
                input.addEventListener('input', function() {
                    clearTimeout(timeout);
                    timeout = setTimeout(function() {
                        pagina = 0; 
                        cargarRegistros();
                    }, 400);
                });
            });

            configurarValidaciones();
        });

        // --- GESTIÓN DE MODALES ---
        
        function abrirModalCrear() {
            modoActual = 'create';
            prepararModal('Nuevo Registro', 'Guardar', 'text-blue-500', 'fa-plus-circle');
            
            document.getElementById('formId').value = "";
            document.getElementById('mainForm').reset();
            resetValidaciones();
            
            document.getElementById('container-captcha').classList.remove('hidden');
            if(window.grecaptcha) grecaptcha.reset();
            mostrarModalVisual();
        }

        function abrirModalEditar(id) {
            modoActual = 'update';
            prepararModal('Editar Registro', 'Actualizar', 'text-yellow-500', 'fa-pen');
            document.getElementById('container-captcha').classList.add('hidden');
            
            // fetch concatenado seguro
            fetch(API.SHOW + "?id=" + id)
                .then(function(r) { return r.json(); })
                .then(function(data) {
                    if(data.exito) {
                        document.getElementById('formId').value = data.data.id;
                        document.getElementById('nombre').value = data.data.nombre;
                        document.getElementById('telefono').value = data.data.telefono;
                        document.getElementById('correo').value = data.data.correo;
                        resetValidaciones();
                        mostrarModalVisual();
                    } else {
                        Swal.fire('Error', 'Datos no encontrados', 'error');
                    }
                })
                .catch(function(e) { Swal.fire('Error', 'Error de conexión', 'error'); });
        }

        function prepararModal(titulo, btnTxt, colorClass, iconClass) {
            document.getElementById('modal-titulo').innerText = titulo;
            document.getElementById('btnText').innerText = btnTxt;
            var icon = document.getElementById('modal-icon');
            icon.className = colorClass;
            icon.innerHTML = '<i class="fas ' + iconClass + '"></i>';
        }

        function mostrarModalVisual() {
            var backdrop = document.getElementById('backdrop');
            var modal = document.getElementById('modalFormulario');
            
            backdrop.style.display = 'block';
            modal.style.display = 'flex';
            
            setTimeout(function() {
                backdrop.classList.add('backdrop-active');
                modal.classList.add('modal-active');
            }, 10);
        }

        function cerrarModal() {
            var backdrop = document.getElementById('backdrop');
            var modal = document.getElementById('modalFormulario');
            
            backdrop.classList.remove('backdrop-active');
            modal.classList.remove('modal-active');
            
            setTimeout(function() {
                backdrop.style.display = 'none';
                modal.style.display = 'none';
            }, 300);
        }

        // --- LÓGICA DE DATOS ---

        function cambiarPagina(delta) {
            pagina += delta;
            if(pagina < 0) pagina = 0;
            cargarRegistros();
        }

        function cargarRegistros() {
            var tbody = document.getElementById('tabla-registros');
            
            tbody.innerHTML = '<tr><td colspan="3" class="px-4 py-12 text-center text-slate-500 animate-pulse">' +
                '<i class="fas fa-circle-notch fa-spin text-2xl mb-2 text-blue-500"></i><p>Cargando registros...</p></td></tr>';

            var clean = function(str) { return str ? str.replace(/[<>&"']/g, '').trim() : ''; };
            var params = new URLSearchParams();
            
            var n = clean(document.getElementById('filtro-nombre').value);
            var t = clean(document.getElementById('filtro-telefono').value);
            var c = clean(document.getElementById('filtro-correo').value);
            if(n) params.append('nombre', n);
            if(t) params.append('telefono', t);
            if(c) params.append('correo', c);

            params.append('offset', pagina * MAX_PER_PAGE);
            params.append('max', MAX_PER_PAGE);

            // fetch concatenado seguro
            fetch(API.LIST + '?' + params.toString())
                .then(function(r) { return r.json(); })
                .then(function(data) {
                    renderizarTabla(data);
                    actualizarControlesPaginacion(data.length);
                })
                .catch(function(e) {
                    tbody.innerHTML = '<tr><td colspan="3" class="text-center text-red-400 py-6"><i class="fas fa-wifi"></i> Error de conexión</td></tr>';
                });
        }

        function renderizarTabla(data) {
            var tbody = document.getElementById('tabla-registros');
            tbody.innerHTML = '';

            if(!data || data.length === 0) {
                tbody.innerHTML = '<tr><td colspan="3" class="px-4 py-12 text-center text-slate-500">' +
                    '<i class="fas fa-folder-open text-4xl mb-3 text-slate-600"></i><p>No se encontraron registros</p></td></tr>';
                return;
            }

            var html = '';
            data.forEach(function(p) {
                var fechaObj = new Date(p.fechaRegistro);
                var fecha = fechaObj.toLocaleDateString('es-ES', {day:'2-digit', month:'2-digit', year:'numeric'});
                var hora = fechaObj.toLocaleTimeString('es-ES', {hour:'2-digit', minute:'2-digit'});

                // Concatenación segura (sin template literals)
                html += '<tr class="hover:bg-slate-700/30 transition-colors border-b border-slate-700/50 last:border-0 group">' +
                    '<td class="px-4 py-3 text-blue-400 font-mono text-xs align-top">' +
                        fecha + '<br><span class="text-slate-500">' + hora + '</span>' +
                    '</td>' +
                    '<td class="px-4 py-3 align-top">' +
                        '<div class="font-bold text-white text-sm mb-1">' + p.nombre + '</div>' +
                        '<div class="text-xs text-slate-400 flex flex-col gap-1">' +
                            '<span class="break-all"><i class="fas fa-envelope mr-1 text-slate-500"></i> ' + p.correo + '</span>' +
                            '<span><i class="fas fa-phone mr-1 text-slate-500"></i> ' + p.telefono + '</span>' +
                        '</div>' +
                    '</td>' +
                    '<td class="px-4 py-3 align-middle text-center">' +
                        '<div class="flex items-center justify-center gap-2">' +
                            '<button onclick="abrirModalEditar(' + p.id + ')" class="p-2 text-yellow-500 hover:bg-yellow-500/10 rounded-lg transition-colors" title="Editar">' +
                                '<i class="fas fa-pen"></i>' +
                            '</button>' +
                            '<button onclick="borrarRegistro(' + p.id + ')" class="p-2 text-red-500 hover:bg-red-500/10 rounded-lg transition-colors" title="Borrar">' +
                                '<i class="fas fa-trash"></i>' +
                            '</button>' +
                        '</div>' +
                    '</td>' +
                '</tr>';
            });
            tbody.innerHTML = html;
        }

        function actualizarControlesPaginacion(cantidadRecibida) {
            document.getElementById('pag-actual').innerText = pagina + 1;
            document.getElementById('btn-prev').disabled = (pagina === 0);
            document.getElementById('btn-next').disabled = (cantidadRecibida < MAX_PER_PAGE);
        }

        function guardarDatos() {
            var btn = document.getElementById('btnGuardar');
            var loader = document.getElementById('btnLoader');
            var text = document.getElementById('btnText');
            
            var nombre = document.getElementById('nombre').value.trim();
            var telefono = document.getElementById('telefono').value.trim();
            if(nombre.length < 3 || telefono.length < 10) return; 

            var token = '';
            if(modoActual === 'create') {
                token = grecaptcha.getResponse();
                if(!token) {
                    document.getElementById('error-captcha').classList.remove('hidden');
                    return;
                }
            }

            btn.disabled = true;
            text.classList.add('hidden');
            loader.classList.remove('hidden');

            var formData = new FormData(document.getElementById('mainForm'));
            if(modoActual === 'create') formData.append('recaptchaToken', token);

            var url = (modoActual === 'create') ? API.SAVE : API.UPDATE;

            fetch(url, { method: 'POST', body: formData })
                .then(function(r) { return r.json(); })
                .then(function(data) {
                    if(data.exito) {
                        cerrarModal();
                        cargarRegistros();
                        Swal.fire({
                            toast: true, position: 'top-end', icon: 'success', 
                            title: data.mensaje, showConfirmButton: false, timer: 3000,
                            background: '#1e293b', color: '#fff'
                        });
                    } else {
                        Swal.fire({ 
                            icon: 'error', title: 'Error', 
                            html: '<p>' + data.mensaje + '</p>', 
                            background: '#1e293b', color: '#fff' 
                        });
                        if(modoActual === 'create') grecaptcha.reset();
                    }
                })
                .catch(function(e) { Swal.fire('Error', 'Fallo técnico', 'error'); })
                .finally(function() {
                    btn.disabled = false;
                    text.classList.remove('hidden');
                    loader.classList.add('hidden');
                });
        }

        function borrarRegistro(id) {
            Swal.fire({
                title: '¿Eliminar registro?', text: "No podrás revertir esta acción.",
                icon: 'warning', background: '#1e293b', color: '#fff',
                showCancelButton: true, confirmButtonColor: '#ef4444', cancelButtonColor: '#334155',
                confirmButtonText: 'Sí, eliminar', cancelButtonText: 'Cancelar'
            }).then(function(result) {
                if (result.isConfirmed) {
                    fetch(API.DELETE + '?id=' + id, { method: 'POST' })
                        .then(function(r) { return r.json(); })
                        .then(function(d) {
                            if(d.exito) {
                                Swal.fire({
                                    toast: true, position: 'top-end', icon: 'success',
                                    title: 'Eliminado', showConfirmButton: false, timer: 2000,
                                    background: '#1e293b', color: '#fff'
                                });
                                cargarRegistros();
                            } else {
                                Swal.fire('Error', d.mensaje, 'error');
                            }
                        });
                }
            });
        }

        // --- VALIDACIONES ---
        function configurarValidaciones() {
            var nombre = document.getElementById('nombre');
            var tele = document.getElementById('telefono');

            nombre.addEventListener('input', function(e) {
                e.target.value = e.target.value.replace(/[^a-zA-ZáéíóúÁÉÍÓÚñÑ\s]/g, '');
                toggleError('nombre', e.target.value.length < 3);
            });

            tele.addEventListener('input', function(e) {
                e.target.value = e.target.value.replace(/\D/g, '');
                toggleError('telefono', e.target.value.length < 10);
            });
        }

        function toggleError(field, show) {
            var el = document.getElementById('error-' + field);
            var input = document.getElementById(field);
            if(show) {
                el.classList.remove('hidden');
                input.classList.add('border-red-500');
                input.classList.remove('border-slate-600');
            } else {
                el.classList.add('hidden');
                input.classList.remove('border-red-500');
                input.classList.add('border-slate-600');
            }
        }

        function resetValidaciones() {
            document.querySelectorAll('.border-red-500').forEach(function(el) { el.classList.remove('border-red-500'); });
            document.querySelectorAll('p[id^="error-"]').forEach(function(el) { el.classList.add('hidden'); });
        }
    </script>
</body>
</html>