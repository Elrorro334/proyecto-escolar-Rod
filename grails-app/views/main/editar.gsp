<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Editar - Proyecto Escolar</title>
    
    <script>
        if (self !== top) { top.location = self.location; }
    </script>
    
    </head>
<body>

<nav class="flex mb-8 text-slate-400 text-sm" aria-label="Breadcrumb">
    <ol class="inline-flex items-center space-x-1 md:space-x-3">
        <li class="inline-flex items-center">
            <a href="${createLink(uri: '/')}" class="inline-flex items-center hover:text-brand-accent transition-colors">
                <i class="fas fa-home mr-2"></i>Inicio
            </a>
        </li>
        <li>
            <div class="flex items-center">
                <span class="mx-2">/</span>
                <a href="${createLink(controller: 'main', action: 'lista')}" class="inline-flex items-center hover:text-brand-accent transition-colors">
                    <i class="fas fa-list mr-2"></i>Registros existentes
                </a>
            </div>
        </li>
        <li aria-current="page">
            <div class="flex items-center">
                <span class="mx-2">/</span>
                <span class="text-white">Editar</span>
            </div>
        </li>
    </ol>
</nav>

    <div class="text-center mb-10">
        <h1 class="text-3xl md:text-4xl font-bold text-white mb-2 tracking-tight">Editar Registro</h1>
    </div>

    <div class="max-w-lg mx-auto bg-slate-800 rounded-xl shadow-2xl border border-slate-700 overflow-hidden">
        
        <div class="h-2 bg-gradient-to-r from-yellow-500 to-orange-600 w-full"></div> 
        
        <div class="p-8">
            <form id="editForm" class="space-y-6" autocomplete="off">
                
                <input type="hidden" id="prospectoId" name="id" value="">

                <div>
                    <label for="nombre" class="block text-sm font-medium text-slate-300 mb-2">Nombre Completo</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        </div>
                        
                        <input type="text" id="nombre" name="nombre" 
                            maxlength="50"
                            class="bg-slate-900 border border-slate-700 text-white text-sm rounded-lg focus:ring-yellow-500 focus:border-yellow-500 block w-full pl-10 p-3 placeholder-slate-600 transition-all shadow-sm" 
                            placeholder="Cargando..." required>
                    </div>
                    <p id="error-nombre" class="mt-2 text-xs text-red-500 hidden"><i class="fas fa-times-circle mr-1"></i> Solo letras permitidas (Mín 3 caracteres)</p>
                </div>

                <div>
                    <label for="telefono" class="block text-sm font-medium text-slate-300 mb-2">Teléfono</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        </div>
                        <input type="text" id="telefono" name="telefono" 
                            maxlength="11"
                            class="bg-slate-900 border border-slate-700 text-white text-sm rounded-lg focus:ring-yellow-500 focus:border-yellow-500 block w-full pl-10 p-3 placeholder-slate-600 transition-all shadow-sm" 
                            placeholder="Cargando..." required>
                    </div>
                    <p id="error-telefono" class="mt-2 text-xs text-red-500 hidden"><i class="fas fa-times-circle mr-1"></i> Solo números permitidos (Mín 3 caracteres)</p>
                </div>

                <div>
                    <label for="correo" class="block text-sm font-medium text-slate-300 mb-2">Correo Electrónico</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        </div>
                        
                        <input type="text" id="correo" name="correo" 
                            maxlength="50"
                            class="bg-slate-900 border border-slate-700 text-white text-sm rounded-lg focus:ring-yellow-500 focus:border-yellow-500 block w-full pl-10 p-3 placeholder-slate-600 transition-all shadow-sm" 
                            placeholder="Cargando..." required>
                    </div>
                    <p id="error-correo" class="mt-2 text-xs text-red-500 hidden"><i class="fas fa-times-circle mr-1"></i> Correo inválido</p>
                </div>

                <button type="submit" id="btnSubmit" class="w-full text-white bg-yellow-600 hover:bg-yellow-700 focus:ring-4 focus:ring-yellow-800 font-medium rounded-lg text-sm px-5 py-3 text-center inline-flex items-center justify-center transition-all shadow-lg hover:shadow-yellow-500/30 disabled:opacity-50 disabled:cursor-not-allowed">
                    <span id="btnText"><i class="fas fa-sync-alt mr-2"></i> Actualizar Registro</span>
                    <span id="btnLoader" class="hidden"><i class="fas fa-spinner fa-spin mr-2"></i> Actualizando...</span>
                </button>

                <div class="text-center pt-4 border-t border-slate-700">
                    <a href="${createLink(controller: 'main', action: 'lista')}" class="text-sm text-slate-400 hover:text-white transition-colors flex items-center justify-center gap-2 group">
                        <i class="fas fa-arrow-left text-slate-500 group-hover:text-yellow-400 transition-colors"></i>
                        Cancelar y volver
                    </a>
                </div>

            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            
            var URL_SHOW = "${createLink(controller: 'api', action: 'show')}";
            var URL_UPDATE = "${createLink(controller: 'api', action: 'update')}";
            var URL_LISTA = "${createLink(controller: 'main', action: 'lista')}";

            var form = document.getElementById('editForm');
            var inputId = document.getElementById('prospectoId');
            var inputNombre = document.getElementById('nombre');
            var inputTelefono = document.getElementById('telefono');
            var inputCorreo = document.getElementById('correo');
            
            var btnSubmit = document.getElementById('btnSubmit');
            var btnText = document.getElementById('btnText');
            var btnLoader = document.getElementById('btnLoader');

            // --- CARGAR DATOS ---
            const params = new URLSearchParams(window.location.search);
            const idRegistro = params.get('id');

            if (!idRegistro) {
                Swal.fire({
                    icon: 'error', title: 'Error', text: 'No se especificó un ID para editar',
                    background: '#1e293b', color: '#fff'
                }).then(() => window.location.href = URL_LISTA);
            } else {
                fetch(URL_SHOW + "?id=" + idRegistro)
                    .then(res => res.json())
                    .then(data => {
                        if (data.exito) {
                            inputId.value = data.data.id;
                            inputNombre.value = data.data.nombre;
                            inputTelefono.value = data.data.telefono;
                            inputCorreo.value = data.data.correo;
                        } else {
                            throw new Error(data.mensaje);
                        }
                    })
                    .catch(err => {
                        Swal.fire({
                            icon: 'error', title: 'Error', text: 'No se encontraron los datos',
                            background: '#1e293b', color: '#fff'
                        }).then(() => window.location.href = URL_LISTA);
                    });
            }

            // --- VALIDACIONES ---
            inputNombre.addEventListener('input', function(e) {
                var cleanVal = e.target.value.replace(/[^a-zA-ZáéíóúÁÉÍÓÚñÑ\s]/g, '');
                if (e.target.value !== cleanVal) e.target.value = cleanVal;
                
                if (cleanVal.length >= 3) {
                    inputNombre.classList.remove('border-red-500');
                    inputNombre.classList.add('border-green-500');
                    document.getElementById('error-nombre').classList.add('hidden');
                }
            });

            inputTelefono.addEventListener('input', function(e) {
                var cleanVal = e.target.value.replace(/\D/g, '');
                if (e.target.value !== cleanVal) e.target.value = cleanVal;

                if (cleanVal.length >= 10) {
                    inputTelefono.classList.remove('border-red-500');
                    inputTelefono.classList.add('border-green-500');
                    document.getElementById('error-telefono').classList.add('hidden');
                }
            });

            // --- SUBMIT (SIN CAPTCHA) ---
            form.addEventListener('submit', function(e) {
                e.preventDefault();
                var valid = true;

                if (inputNombre.value.trim().length < 3) {
                    inputNombre.classList.add('border-red-500');
                    document.getElementById('error-nombre').classList.remove('hidden');
                    valid = false;
                }
                if (inputTelefono.value.length < 10) {
                    inputTelefono.classList.add('border-red-500');
                    document.getElementById('error-telefono').classList.remove('hidden');
                    valid = false;
                }

                if (!valid) {
                    Swal.fire({ 
                        toast: true, position: 'top-end', showConfirmButton: false, timer: 3000,
                        icon: 'warning', title: 'Verifica los campos', background: '#1e293b', color: '#fff' 
                    });
                    return;
                }

                btnSubmit.disabled = true;
                btnText.classList.add('hidden');
                btnLoader.classList.remove('hidden');

                var formData = new FormData(form);
                
                // NO AGREGAMOS 'recaptchaToken' PORQUE YA NO LO USAMOS

                fetch(URL_UPDATE, {
                    method: 'POST',
                    body: formData
                })
                .then(function(response) { return response.json(); })
                .then(function(data) {
                    if (data.exito) {
                        Swal.fire({
                            title: '¡Actualizado!',
                            text: data.mensaje,
                            icon: 'success',
                            background: '#1e293b', color: '#fff',
                            confirmButtonColor: '#ca8a04',
                            confirmButtonText: 'Volver a la lista'
                        }).then(function() {
                            window.location.href = URL_LISTA;
                        });
                    } else {
                        var htmlMsg = '<div style="text-align: left;">';
                        htmlMsg += '<p style="font-weight: bold; margin-bottom: 8px;">' + data.mensaje + '</p>';
                        
                        if (data.errores && Array.isArray(data.errores)) {
                            htmlMsg += '<ul style="font-size: 0.9em; color: #f87171; list-style-type: disc; padding-left: 20px;">';
                            data.errores.forEach(function(err) {
                                htmlMsg += '<li>' + err + '</li>';
                            });
                            htmlMsg += '</ul>';
                        }
                        htmlMsg += '</div>';

                        Swal.fire({ 
                            icon: 'error', title: 'No se pudo actualizar', html: htmlMsg, 
                            background: '#1e293b', color: '#fff' 
                        });
                    }
                })
                .catch(function(err) {
                    console.error(err);
                    Swal.fire({ icon: 'error', title: 'Error de red', text: 'No se pudo contactar con el servidor', background: '#1e293b', color: '#fff' });
                })
                .finally(function() {
                    btnSubmit.disabled = false;
                    btnText.classList.remove('hidden');
                    btnLoader.classList.add('hidden');
                });
            });
        });
    </script>

</body>
</html>