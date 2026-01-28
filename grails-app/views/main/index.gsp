<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Inicio - Proyecto Escolar</title>
    
    <meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self' 'unsafe-inline' https://www.google.com https://www.gstatic.com https://cdn.jsdelivr.net; style-src 'self' 'unsafe-inline' https://cdnjs.cloudflare.com; font-src 'self' https://cdnjs.cloudflare.com; frame-src https://www.google.com;">
    
    <script>
        if (self !== top) { top.location = self.location; }
    </script>
    
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
            <li aria-current="page">
                <div class="flex items-center"></div>
            </li>
        </ol>
    </nav>

    <div class="text-center mb-10">
        <h1 class="text-3xl md:text-4xl font-bold text-white mb-2 tracking-tight">Hola Mundo</h1>
    </div>

    <div class="max-w-lg mx-auto bg-brand-panel rounded-xl shadow-2xl border border-slate-700 overflow-hidden">
        
        <div class="h-2 bg-gradient-to-r from-blue-600 to-indigo-600 w-full"></div>

        <div class="p-8">
            <g:form controller="main" action="save" method="POST" name="schoolForm" 
                    class="space-y-6" useToken="true" autocomplete="off" novalidate="novalidate">
                
                <div>
                    <label for="nombre" class="block text-sm font-medium text-slate-300 mb-2">Nombre Completo</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i id="icon-user" class="fas fa-user text-slate-500 transition-colors"></i>
                        </div>
                        
                        <input type="text" id="nombre" name="nombre" 
                               value="${nombre?.encodeAsHTML()}" 
                               maxlength="50"
                               pattern="^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$"
                               onpaste="return false"
                               ondrop="return false"
                               autocomplete="off"
                               class="bg-slate-900 border border-slate-700 text-white text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-3 placeholder-slate-600 transition-all shadow-sm" 
                               placeholder="Ej. Rodrigo Sánchez" required>
                    </div>
                    <p id="error-nombre" class="mt-2 text-xs text-red-500 hidden"><i class="fas fa-times-circle mr-1"></i> Solo letras permitidas (Mín 3 caracteres)</p>
                </div>

                <div class="flex justify-center my-4 transform scale-90 md:scale-100 origin-center">
                    <div class="g-recaptcha" data-sitekey="6LcxNUMsAAAAAJCF18aZ7IRp8F_FEbDCAr-rgChp" data-theme="dark"></div>
                </div>
                <div id="error-captcha" class="text-center text-xs text-red-500 hidden mb-2">
                    <i class="fas fa-robot mr-1"></i> Debes verificar que no eres un robot
                </div>

                <button type="submit" id="btnSubmit" class="w-full text-white bg-blue-600 hover:bg-blue-700 focus:ring-4 focus:ring-blue-800 font-medium rounded-lg text-sm px-5 py-3 text-center inline-flex items-center justify-center transition-all shadow-lg hover:shadow-blue-500/30 disabled:opacity-50 disabled:cursor-not-allowed">
                    <i class="fas fa-save mr-2"></i>
                    Guardar Registro
                </button>

                <div class="text-center pt-4 border-t border-slate-700">
                    <a href="${createLink(controller: 'main', action: 'lista')}" class="text-sm text-slate-400 hover:text-white transition-colors flex items-center justify-center gap-2 group">
                        <i class="fas fa-list-ul text-slate-500 group-hover:text-blue-400 transition-colors"></i>
                        Ver registros existentes
                    </a>
                </div>

            </g:form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            
            // --- CONFIGURACIÓN TOAST ---
            const Toast = Swal.mixin({
                toast: true, position: 'top-end', showConfirmButton: false, timer: 3000, timerProgressBar: true,
                background: '#1e293b', color: '#f8fafc',
                didOpen: (toast) => {
                    toast.addEventListener('mouseenter', Swal.stopTimer)
                    toast.addEventListener('mouseleave', Swal.resumeTimer)
                }
            });

            // --- SEGURIDAD 5: Input Hardening (Sanitización Activa) ---
            const inputNombre = document.getElementById('nombre');
            const iconUser = document.getElementById('icon-user');
            const errorNombre = document.getElementById('error-nombre');

            inputNombre.addEventListener('input', function(e) {
                // Elimina cualquier caracter que NO sea letra o espacio inmediatamente
                const cleanVal = e.target.value.replace(/[^a-zA-ZáéíóúÁÉÍÓÚñÑ\s]/g, '');
                if (e.target.value !== cleanVal) {
                    e.target.value = cleanVal;
                }
                
                // Feedback visual simple
                if (cleanVal.length >= 3) {
                    inputNombre.classList.replace('border-red-500', 'border-green-500');
                    inputNombre.classList.replace('border-slate-700', 'border-green-500');
                    iconUser.classList.replace('text-slate-500', 'text-green-500');
                    errorNombre.classList.add('hidden');
                } else {
                    inputNombre.classList.replace('border-green-500', 'border-slate-700');
                    iconUser.classList.replace('text-green-500', 'text-slate-500');
                }
            });

            // --- SEGURIDAD 6: Gatekeeper en Submit ---
            document.getElementById('schoolForm').addEventListener('submit', function(e) {
                e.preventDefault();
                let valid = true;

                // 1. Validar Nombre
                const nombreVal = inputNombre.value.trim();
                if (nombreVal.length < 3 || nombreVal.length > 50) {
                    inputNombre.classList.add('border-red-500');
                    errorNombre.classList.remove('hidden');
                    valid = false;
                }

                // 2. Validar Recaptcha
                const captchaResponse = grecaptcha.getResponse();
                const errorCaptcha = document.getElementById('error-captcha');
                if (captchaResponse.length === 0) {
                    errorCaptcha.classList.remove('hidden');
                    valid = false;
                } else {
                    errorCaptcha.classList.add('hidden');
                }

                if (!valid) {
                    Toast.fire({ icon: 'warning', title: 'Verifica los campos requeridos' });
                    return false;
                }

                // Si todo es válido, bloqueamos botón y enviamos
                const btn = document.getElementById('btnSubmit');
                btn.disabled = true;
                btn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i> Procesando...';
                this.submit();
            });

            // --- SEGURIDAD 7: Escapado de mensajes Flash (Anti-XSS) ---
            <g:if test="${flash.error || error}">
                Toast.fire({ icon: 'error', title: '${(flash.error ?: error)?.encodeAsJavaScript()}' });
            </g:if>
            
            <g:if test="${flash.message}">
                Toast.fire({ icon: 'success', title: '${flash.message?.encodeAsJavaScript()}' });
            </g:if>
        });
    </script>

</body>
</html>