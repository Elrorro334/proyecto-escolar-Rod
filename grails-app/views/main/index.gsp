<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Inicio - Proyecto Escolar</title>
    
    <meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self' 'unsafe-inline' https://www.google.com https://www.gstatic.com https://cdn.jsdelivr.net; style-src 'self' 'unsafe-inline' https://cdnjs.cloudflare.com https://fonts.googleapis.com; font-src 'self' https://cdnjs.cloudflare.com https://fonts.gstatic.com; frame-src https://www.google.com;">
    
    <script>
        if (self !== top) { top.location = self.location; }
    </script>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
</head>
<body>

    <nav class="flex mb-8 text-slate-400 text-sm" aria-label="Breadcrumb">
        <ol class="inline-flex items-center space-x-1 md:space-x-3">
            <li class="inline-flex items-center">
                <a href="${createLink(uri: '/')}" class="inline-flex items-center hover:text-brand-accent transition-colors">
                    <i class="fas fa-home mr-2"></i>Inicio
                </a>
            </li>
        </ol>
    </nav>

    <div class="text-center mb-10">
        <h1 class="text-3xl md:text-4xl font-bold text-white mb-2 tracking-tight">Registro Escolar</h1>
        <p class="text-slate-400">Ingresa tus datos para continuar</p>
    </div>

    <div class="max-w-lg mx-auto bg-slate-800 rounded-xl shadow-2xl border border-slate-700 overflow-hidden">
        
        <div class="h-2 bg-gradient-to-r from-blue-600 to-indigo-600 w-full"></div>

        <div class="p-8">
            <form id="schoolForm" class="space-y-6" autocomplete="off">
                
                <div>
                    <label for="nombre" class="block text-sm font-medium text-slate-300 mb-2">Nombre Completo</label>
                    <div class="relative">
                        <input type="text" id="nombre" name="nombre" 
                               maxlength="50"
                               class="bg-slate-900 border border-slate-700 text-white text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-3 placeholder-slate-600 transition-all shadow-sm" 
                               placeholder="Ej. Rodrigo Sánchez" required>
                    </div>
                    <p id="error-nombre" class="mt-2 text-xs text-red-500 hidden"><i class="fas fa-times-circle mr-1"></i> Solo letras (Mín 3 caracteres)</p>
                </div>

                <div>
                    <label for="telefono" class="block text-sm font-medium text-slate-300 mb-2">Teléfono</label>
                    <div class="relative">
                        <input type="tel" id="telefono" name="telefono" 
                               maxlength="11"
                               class="bg-slate-900 border border-slate-700 text-white text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-3 placeholder-slate-600 transition-all shadow-sm" 
                               placeholder="Ej. 5512345678" required>
                    </div>
                    <p id="error-telefono" class="mt-2 text-xs text-red-500 hidden"><i class="fas fa-times-circle mr-1"></i> Solo números (10 a 11 dígitos)</p>
                </div>

                <div>
                    <label for="correo" class="block text-sm font-medium text-slate-300 mb-2">Correo Electrónico</label>
                    <div class="relative">
                        <input type="email" id="correo" name="correo" 
                               maxlength="100"
                               class="bg-slate-900 border border-slate-700 text-white text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-3 placeholder-slate-600 transition-all shadow-sm" 
                               placeholder="Ej. usuario@ejemplo.com" required>
                    </div>
                </div>

                <div class="flex justify-center my-4 transform scale-90 md:scale-100 origin-center">
                    <div class="g-recaptcha" data-sitekey="6LcxNUMsAAAAAJCF18aZ7IRp8F_FEbDCAr-rgChp" data-theme="dark"></div>
                </div>
                <div id="error-captcha" class="text-center text-xs text-red-500 hidden mb-2">
                    <i class="fas fa-robot mr-1"></i> Debes verificar el Captcha
                </div>

                <button type="submit" id="btnSubmit" class="w-full text-white bg-blue-600 hover:bg-blue-700 focus:ring-4 focus:ring-blue-800 font-medium rounded-lg text-sm px-5 py-3 text-center inline-flex items-center justify-center transition-all shadow-lg hover:shadow-blue-500/30 disabled:opacity-50 disabled:cursor-not-allowed">
                    <span id="btnText"><i class="fas fa-save mr-2"></i> Guardar Registro</span>
                    <span id="btnLoader" class="hidden"><i class="fas fa-spinner fa-spin mr-2"></i> Procesando...</span>
                </button>

            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {

            // Generamos la URL una sola vez con GSP
            var URL_SAVE = "${createLink(controller: 'api', action: 'save')}";

            var form = document.getElementById('schoolForm');
            var inputNombre = document.getElementById('nombre');
            var inputTelefono = document.getElementById('telefono');
            var errorNombre = document.getElementById('error-nombre');
            var errorTelefono = document.getElementById('error-telefono');
            var errorCaptcha = document.getElementById('error-captcha');
            
            var btnSubmit = document.getElementById('btnSubmit');
            var btnText = document.getElementById('btnText');
            var btnLoader = document.getElementById('btnLoader');

            // --- VALIDACIONES FRONTEND ---
            inputNombre.addEventListener('input', function(e) {
                var valorLimpio = e.target.value.replace(/[^a-zA-ZáéíóúÁÉÍÓÚñÑ\s]/g, '');
                if (e.target.value !== valorLimpio) e.target.value = valorLimpio;
                
                if (valorLimpio.length >= 3) {
                    inputNombre.classList.remove('border-red-500');
                    inputNombre.classList.add('border-green-500');
                    errorNombre.classList.add('hidden');
                } else {
                    inputNombre.classList.remove('border-green-500');
                }
            });

            inputTelefono.addEventListener('input', function(e) {
                var valorLimpio = e.target.value.replace(/\D/g, '');
                if (e.target.value !== valorLimpio) e.target.value = valorLimpio;

                if (valorLimpio.length >= 10) {
                    inputTelefono.classList.remove('border-red-500');
                    inputTelefono.classList.add('border-green-500');
                    errorTelefono.classList.add('hidden');
                } else {
                    inputTelefono.classList.remove('border-green-500');
                }
            });

            // --- ENVÍO DEL FORMULARIO ---
            form.addEventListener('submit', function(e) {
                e.preventDefault();

                var valid = true;
                
                if (inputNombre.value.trim().length < 3) {
                    inputNombre.classList.add('border-red-500');
                    errorNombre.classList.remove('hidden');
                    valid = false;
                }

                if (inputTelefono.value.length < 10) {
                    inputTelefono.classList.add('border-red-500');
                    errorTelefono.classList.remove('hidden');
                    valid = false;
                }

                var captchaResponse = grecaptcha.getResponse();
                if (captchaResponse.length === 0) {
                    errorCaptcha.classList.remove('hidden');
                    valid = false;
                } else {
                    errorCaptcha.classList.add('hidden');
                }

                if (!valid) {
                    Swal.fire({
                        toast: true, position: 'top-end', showConfirmButton: false, timer: 3000,
                        icon: 'warning', title: 'Verifica los campos marcados',
                        background: '#1e293b', color: '#fff'
                    });
                    return;
                }

                btnSubmit.disabled = true;
                btnText.classList.add('hidden');
                btnLoader.classList.remove('hidden');

                var formData = new FormData(form);
                formData.append('recaptchaToken', captchaResponse);

                fetch(URL_SAVE, {
                    method: 'POST',
                    body: formData
                })
                .then(function(response) {
                    return response.json();
                })
                .then(function(data) {
                    if (data.exito) {
                        Swal.fire({
                            toast: true, position: 'top-end', showConfirmButton: false, timer: 3000,
                            icon: 'success', title: data.mensaje,
                            background: '#1e293b', color: '#fff'
                        });
                        
                        form.reset();
                        grecaptcha.reset();
                        inputNombre.classList.remove('border-green-500');
                        inputTelefono.classList.remove('border-green-500');
                        
                    } else {
                        // Construcción de mensaje de error seguro (concatenación simple)
                        var htmlMsg = '<div style="text-align: left;">';
                        htmlMsg += '<p style="font-weight: bold; margin-bottom: 8px;">' + data.mensaje + '</p>';
                        
                        if (data.errores && Array.isArray(data.errores)) {
                            htmlMsg += '<ul style="font-size: 0.9em; color: #f87171; list-style-type: disc; padding-left: 20px;">';
                            data.errores.forEach(function(err) {
                                htmlMsg += '<li>' + err + '</li>';
                            });
                            htmlMsg += '</ul>';
                        }
                        
                        if (data.tipoError) {
                            htmlMsg += '<div style="margin-top: 10px; padding: 8px; background: #334155; border-radius: 4px; font-size: 0.8em; color: #cbd5e1; font-family: monospace;">';
                            htmlMsg += 'Error Técnico: ' + data.tipoError;
                            htmlMsg += '</div>';
                        }

                        htmlMsg += '</div>';

                        Swal.fire({
                            icon: 'error', 
                            title: 'No se pudo guardar', 
                            html: htmlMsg, 
                            background: '#1e293b', 
                            color: '#fff',
                            confirmButtonColor: '#3b82f6'
                        });
                        grecaptcha.reset(); 
                    }
                })
                .catch(function(error) {
                    console.error('Error de red:', error);
                    Swal.fire({
                        icon: 'error', title: 'Error de conexión', 
                        text: 'No se pudo contactar con el servidor.',
                        background: '#1e293b', color: '#fff'
                    });
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