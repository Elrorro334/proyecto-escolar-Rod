<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Gestión de Registros</title>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        .modal-transition { transition: all 0.3s ease-out; opacity: 0; transform: scale(0.95); pointer-events: none; }
        .modal-active { opacity: 1; transform: scale(1); pointer-events: auto; }
        .backdrop-transition { transition: opacity 0.3s ease-out; opacity: 0; pointer-events: none; }
        .backdrop-active { opacity: 1; pointer-events: auto; }
    </style>
</head>
<body>

    <nav class="flex flex-wrap mb-6 text-slate-400 text-sm w-full" aria-label="Breadcrumb">
        <ol class="inline-flex items-center space-x-2">
            <li><a href="${createLink(uri: '/')}" class="hover:text-blue-500 flex items-center"><i class="fas fa-home mr-2"></i> Inicio</a></li>
            <li><span class="text-slate-600">/</span></li>
            <li class="text-blue-500 font-medium">Gestión</li>
        </ol>
    </nav>

    <div class="flex flex-col gap-4 mb-6 w-full">
        <div class="flex flex-col md:flex-row justify-between items-end gap-4">
            <h2 class="text-2xl font-bold text-white tracking-tight">Gestión de Registros</h2>
            <button onclick="abrirModalCrear()" class="bg-blue-600 hover:bg-blue-500 text-white px-5 py-2.5 rounded-xl text-sm font-semibold shadow-lg transition-all flex items-center hover:scale-105 active:scale-95">
                <i class="fas fa-plus mr-2"></i> Nuevo
            </button>
        </div>

        <div class="bg-slate-800/50 backdrop-blur-sm p-4 rounded-xl border border-slate-700/50 grid grid-cols-1 md:grid-cols-3 gap-4 shadow-sm">
            <div class="relative group">
                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none text-slate-500"><i class="fas fa-user"></i></div>
                <input type="text" id="filtro-nombre" class="filtro-input bg-slate-900/80 border border-slate-700 text-slate-200 text-sm rounded-lg focus:ring-2 focus:ring-blue-500 block w-full pl-10 p-2.5" placeholder="Nombre...">
            </div>
            <div class="relative group">
                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none text-slate-500"><i class="fas fa-phone"></i></div>
                <input type="tel" id="filtro-telefono" class="filtro-input bg-slate-900/80 border border-slate-700 text-slate-200 text-sm rounded-lg focus:ring-2 focus:ring-blue-500 block w-full pl-10 p-2.5" placeholder="Teléfono...">
            </div>
            <div class="relative group">
                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none text-slate-500"><i class="fas fa-envelope"></i></div>
                <input type="email" id="filtro-correo" class="filtro-input bg-slate-900/80 border border-slate-700 text-slate-200 text-sm rounded-lg focus:ring-2 focus:ring-blue-500 block w-full pl-10 p-2.5" placeholder="Correo...">
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
                    <tr><td colspan="3" class="px-4 py-8 text-center animate-pulse text-slate-500">Cargando...</td></tr>
                </tbody>
            </table>
        </div>
        
        <div class="bg-slate-900/50 px-4 py-3 border-t border-slate-700 flex flex-col sm:flex-row items-center justify-between gap-4">
            <span class="text-xs text-slate-400">
                Mostrando página <span id="pag-actual" class="text-white font-bold">1</span> de <span id="pag-total" class="text-white font-bold">1</span>
            </span>
            
            <div class="flex gap-1">
                <button id="btn-first" onclick="irAPagina(0)" disabled class="px-3 py-1.5 text-xs font-medium text-slate-300 bg-slate-800 border border-slate-600 rounded-l-lg hover:bg-slate-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors" title="Primera página">
                    <i class="fas fa-angle-double-left"></i>
                </button>
                
                <button id="btn-prev" onclick="cambiarPagina(-1)" disabled class="px-3 py-1.5 text-xs font-medium text-slate-300 bg-slate-800 border-y border-r border-slate-600 hover:bg-slate-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors">
                    <i class="fas fa-chevron-left mr-1"></i> Anterior
                </button>
                
                <button id="btn-next" onclick="cambiarPagina(1)" disabled class="px-3 py-1.5 text-xs font-medium text-slate-300 bg-slate-800 border-y border-l border-slate-600 hover:bg-slate-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors">
                    Siguiente <i class="fas fa-chevron-right ml-1"></i>
                </button>
                
                <button id="btn-last" onclick="irAUltima()" disabled class="px-3 py-1.5 text-xs font-medium text-slate-300 bg-slate-800 border border-slate-600 rounded-r-lg hover:bg-slate-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors" title="Última página">
                    <i class="fas fa-angle-double-right"></i>
                </button>
            </div>
        </div>
    </div>

    <div id="backdrop" class="fixed inset-0 z-40 bg-slate-900/80 backdrop-blur-sm backdrop-transition"></div>
    
    <div id="modalFormulario" class="fixed inset-0 z-50 flex items-center justify-center p-4 modal-transition">
        <div class="relative w-full max-w-lg bg-slate-800 rounded-2xl shadow-2xl border border-slate-700 overflow-hidden transform transition-all">
            
            <div class="bg-gradient-to-r from-slate-900 to-slate-800 px-6 py-4 border-b border-slate-700 flex justify-between items-center">
                <h3 class="text-lg font-bold text-white flex items-center gap-2">
                    <span id="modal-icon"></span> <span id="modal-titulo">Registro</span>
                </h3>
                <button onclick="cerrarModal()" class="text-slate-400 hover:text-white bg-slate-700/50 hover:bg-red-500/80 rounded-full w-8 h-8 flex items-center justify-center transition-all"><i class="fas fa-times"></i></button>
            </div>

            <div class="px-6 py-6">
                <form id="mainForm" autocomplete="off" class="space-y-5">
                    <input type="hidden" id="formId" name="id">
                    
                    <div class="space-y-1">
                        <label class="text-xs font-semibold text-slate-400 uppercase ml-1">Nombre</label>
                        <input type="text" id="nombre" name="nombre" maxlength="50" class="w-full bg-slate-900/50 border border-slate-600 rounded-xl px-4 py-3 text-white focus:ring-2 focus:ring-blue-500 outline-none">
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div class="space-y-1">
                            <label class="text-xs font-semibold text-slate-400 uppercase ml-1">Teléfono</label>
                            <input type="tel" id="telefono" name="telefono" maxlength="11" class="w-full bg-slate-900/50 border border-slate-600 rounded-xl px-4 py-3 text-white focus:ring-2 focus:ring-blue-500 outline-none">
                        </div>
                        <div class="space-y-1">
                            <label class="text-xs font-semibold text-slate-400 uppercase ml-1">Correo</label>
                            <input type="email" id="correo" name="correo" maxlength="60" class="w-full bg-slate-900/50 border border-slate-600 rounded-xl px-4 py-3 text-white focus:ring-2 focus:ring-blue-500 outline-none">
                        </div>
                    </div>

                    <div id="container-captcha" class="flex justify-center pt-2"><div class="g-recaptcha" data-sitekey="6LcxNUMsAAAAAJCF18aZ7IRp8F_FEbDCAr-rgChp" data-theme="dark"></div></div>
                </form>
            </div>

            <div class="bg-slate-900/50 px-6 py-4 border-t border-slate-700 flex justify-end gap-3">
                <button onclick="cerrarModal()" class="px-4 py-2 text-sm font-medium text-slate-300 hover:bg-slate-700 rounded-lg">Cancelar</button>
                <button id="btnGuardar" onclick="guardarDatos()" class="px-6 py-2 text-sm font-medium text-white bg-blue-600 hover:bg-blue-500 rounded-lg shadow-lg flex items-center gap-2">
                    <span id="btnLoader" class="hidden"><i class="fas fa-spinner fa-spin"></i></span>
                    <span id="btnText">Guardar</span>
                </button>
            </div>
        </div>
    </div>

    <script>
        // URLs
        var API = {
            LIST:   "${createLink(controller: 'api', action: 'index')}",
            SAVE:   "${createLink(controller: 'api', action: 'save')}",
            UPDATE: "${createLink(controller: 'api', action: 'update')}",
            DELETE: "${createLink(controller: 'api', action: 'delete')}",
            SHOW:   "${createLink(controller: 'api', action: 'show')}"
        };

        // Estado Paginación
        var pagina = 0;
        var MAX = 5;
        var totalRegistros = 0;
        var modo = 'create';

        document.addEventListener("DOMContentLoaded", function() {
            cargarRegistros();
            
            var inputs = document.querySelectorAll('.filtro-input');
            var t;
            inputs.forEach(function(i) {
                i.addEventListener('input', function() {
                    clearTimeout(t);
                    t = setTimeout(function() { pagina=0; cargarRegistros(); }, 400);
                });
            });
        });

        // --- PAGINACIÓN ---
        function cambiarPagina(d) {
            pagina += d;
            if(pagina < 0) pagina = 0;
            cargarRegistros();
        }

        function irAPagina(p) {
            pagina = p;
            cargarRegistros();
        }

        function irAUltima() {
            var totalPaginas = Math.ceil(totalRegistros / MAX);
            pagina = totalPaginas > 0 ? totalPaginas - 1 : 0;
            cargarRegistros();
        }

        function cargarRegistros() {
            var tb = document.getElementById('tabla-registros');
            tb.innerHTML = '<tr><td colspan="3" class="px-4 py-8 text-center text-slate-500">Cargando...</td></tr>';

            var p = new URLSearchParams();
            p.append('max', MAX);
            p.append('offset', pagina * MAX);
            
            var n = document.getElementById('filtro-nombre').value;
            if(n) p.append('nombre', n);
            
            fetch(API.LIST + "?" + p.toString())
                .then(function(r){ return r.json(); })
                .then(function(res){
                    totalRegistros = res.total || 0;
                    renderTabla(res.data || []);
                    actualizarPaginacion(res.data ? res.data.length : 0);
                })
                .catch(function(){ tb.innerHTML = '<tr><td colspan="3" class="text-center text-red-500">Error</td></tr>'; });
        }

        function actualizarPaginacion(recibidos) {
            var totalPaginas = Math.ceil(totalRegistros / MAX);
            if (totalPaginas === 0) totalPaginas = 1;

            document.getElementById('pag-actual').innerText = pagina + 1;
            document.getElementById('pag-total').innerText = totalPaginas;

            // Lógica de botones
            document.getElementById('btn-first').disabled = (pagina === 0);
            document.getElementById('btn-prev').disabled = (pagina === 0);
            
            // Deshabilitar "Siguiente" si estamos en la última página
            var esUltima = (pagina + 1) >= totalPaginas;
            document.getElementById('btn-next').disabled = esUltima;
            document.getElementById('btn-last').disabled = esUltima;
        }

        // --- RENDER ---
        function renderTabla(data) {
            var tb = document.getElementById('tabla-registros');
            tb.innerHTML = '';
            if(data.length === 0) {
                tb.innerHTML = '<tr><td colspan="3" class="px-4 py-8 text-center text-slate-500">Sin datos</td></tr>';
                return;
            }
            var h = '';
            data.forEach(function(d) {
                var f = new Date(d.fechaRegistro).toLocaleDateString();
                h += '<tr class="hover:bg-slate-700/30 border-b border-slate-700/50">' +
                     '<td class="px-4 py-3 text-blue-400 text-xs">' + f + '</td>' +
                     '<td class="px-4 py-3"><div class="font-bold text-white text-sm">' + d.nombre + '</div><div class="text-xs text-slate-400">' + d.correo + '</div></td>' +
                     '<td class="px-4 py-3 text-center">' +
                        '<button onclick="abrirModalEditar(' + d.id + ')" class="text-yellow-500 mr-3"><i class="fas fa-pen"></i></button>' +
                        '<button onclick="borrarRegistro(' + d.id + ')" class="text-red-500"><i class="fas fa-trash"></i></button>' +
                     '</td></tr>';
            });
            tb.innerHTML = h;
        }

        // --- MODAL ---
        function abrirModalCrear() {
            modo = 'create';
            prepModal('Nuevo Registro', 'Guardar', 'text-blue-500', 'fa-plus-circle');
            document.getElementById('formId').value = "";
            document.getElementById('mainForm').reset();
            document.getElementById('container-captcha').style.display = 'flex';
            if(window.grecaptcha) grecaptcha.reset();
            verModal();
        }

        function abrirModalEditar(id) {
            modo = 'update';
            prepModal('Editar Registro', 'Actualizar', 'text-yellow-500', 'fa-pen');
            document.getElementById('container-captcha').style.display = 'none';
            
            fetch(API.SHOW + "?id=" + id)
                .then(function(r){ return r.json(); })
                .then(function(d){
                    if(d.exito) {
                        document.getElementById('formId').value = d.data.id;
                        document.getElementById('nombre').value = d.data.nombre;
                        document.getElementById('telefono').value = d.data.telefono;
                        document.getElementById('correo').value = d.data.correo;
                        verModal();
                    }
                });
        }

        function prepModal(t, b, c, i) {
            document.getElementById('modal-titulo').innerText = t;
            document.getElementById('btnText').innerText = b;
            document.getElementById('modal-icon').className = "fas " + i + " " + c;
        }

        function verModal() {
            document.getElementById('backdrop').style.display = 'block';
            document.getElementById('modalFormulario').style.display = 'flex';
            setTimeout(function(){
                document.getElementById('backdrop').classList.add('backdrop-active');
                document.getElementById('modalFormulario').classList.add('modal-active');
            }, 10);
        }

        function cerrarModal() {
            document.getElementById('backdrop').classList.remove('backdrop-active');
            document.getElementById('modalFormulario').classList.remove('modal-active');
            setTimeout(function(){
                document.getElementById('backdrop').style.display = 'none';
                document.getElementById('modalFormulario').style.display = 'none';
            }, 300);
        }

        // --- CRUD ---
        function guardarDatos() {
            var btn = document.getElementById('btnGuardar');
            var ld = document.getElementById('btnLoader');
            var tx = document.getElementById('btnText');
            
            // Validar
            var nom = document.getElementById('nombre').value;
            var tel = document.getElementById('telefono').value;
            if(nom.length < 3 || tel.length < 10) { Swal.fire('Atención', 'Verifica los datos', 'warning'); return; }

            var token = '';
            if(modo === 'create') {
                token = grecaptcha.getResponse();
                if(!token) { Swal.fire('Captcha', 'Verifica el captcha', 'warning'); return; }
            }

            btn.disabled = true; tx.classList.add('hidden'); ld.classList.remove('hidden');

            var fd = new FormData(document.getElementById('mainForm'));
            if(modo === 'create') fd.append('recaptchaToken', token);

            var u = (modo === 'create') ? API.SAVE : API.UPDATE;

            fetch(u, { method: 'POST', body: fd })
                .then(function(r){ return r.json(); })
                .then(function(d){
                    if(d.exito) {
                        cerrarModal(); // Solo se cierra SI hubo éxito
                        cargarRegistros();
                        Swal.fire({ icon: 'success', title: 'Listo', text: d.mensaje, timer: 2000, showConfirmButton: false, background:'#1e293b', color:'#fff' });
                    } else {
                        Swal.fire({ icon: 'error', title: 'Error', text: d.mensaje, background:'#1e293b', color:'#fff' });
                        if(modo === 'create') grecaptcha.reset();
                        // NO cerramos el modal aquí para que el usuario corrija
                    }
                })
                .finally(function(){
                    btn.disabled = false; tx.classList.remove('hidden'); ld.classList.add('hidden');
                });
        }

        function borrarRegistro(id) {
            Swal.fire({
                title: '¿Eliminar?', icon: 'warning', showCancelButton: true, 
                confirmButtonColor: '#ef4444', background: '#1e293b', color: '#fff'
            }).then(function(res){
                if(res.isConfirmed) {
                    fetch(API.DELETE + "?id=" + id, { method: 'POST' })
                        .then(function(r){ return r.json(); })
                        .then(function(d){
                            if(d.exito) {
                                cargarRegistros();
                                Swal.fire({ icon:'success', title:'Eliminado', timer:1500, showConfirmButton:false, background:'#1e293b', color:'#fff' });
                            }
                        });
                }
            });
        }
    </script>
</body>
</html>