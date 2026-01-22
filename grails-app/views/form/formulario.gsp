<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Formulario de Prueba</title>
</head>
<body>

    <nav class="flex mb-6 text-slate-400 text-sm" aria-label="Breadcrumb">
        <ol class="inline-flex items-center space-x-2">
            <li>
                <a href="${createLink(uri: '/')}" class="hover:text-blue-500 transition-colors flex items-center">
                    <i class="fas fa-home mr-2"></i> Inicio
                </a>
            </li>
            <li><span class="text-slate-600">/</span></li>
            <li class="text-blue-500 font-medium">Formulario de Prueba</li>
        </ol>
    </nav>

    <div class="mb-8 border-b border-slate-700 pb-5">
        <h2 class="text-2xl font-bold text-white">Formulario de Prueba</h2>
        <p class="mt-1 text-sm text-slate-400">
            Validación estricta en frontend antes de enviar al servidor.
        </p>
    </div>

    <div class="bg-slate-800 rounded-xl shadow-2xl border border-slate-700 overflow-hidden max-w-4xl mx-auto">
        
        <div class="h-1 w-full bg-slate-900">
            <div class="h-full bg-blue-600 w-1/2"></div>
        </div>

        <div class="p-6 sm:p-8">
            <g:form controller="form" action="simular" name="careerForm" class="space-y-6">

                <div>
                    <h3 class="text-lg font-semibold text-white mb-4 border-b border-slate-700 pb-2">
                        <i class="fas fa-id-card text-blue-500 mr-2"></i> Datos Personales
                    </h3>
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        
                        <div>
                            <label class="block text-xs font-medium text-slate-400 mb-1 uppercase">Nombre Completo <span class="text-red-500">*</span></label>
                            <div class="relative">
                                <g:textField name="nombre" required="true" minlength="5" 
                                    oninput="this.value = this.value.replace(/[^a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]/g, '')"
                                    placeholder="Ej. Rodrigo Sánchez"
                                    class="peer block w-full rounded-lg bg-slate-900 border-slate-600 text-white p-3 border 
                                           focus:ring-2 focus:ring-blue-500 outline-none
                                           valid:border-green-500 valid:ring-1 valid:ring-green-500/30
                                           invalid:border-pink-500 invalid:text-pink-100 transition-all"/>
                                <p class="mt-1 text-[10px] text-slate-500 peer-invalid:text-pink-500">Solo letras. Mínimo 5 caracteres.</p>
                            </div>
                        </div>

                        <div>
                            <label class="block text-xs font-medium text-slate-400 mb-1 uppercase">Email Corporativo <span class="text-red-500">*</span></label>
                            <g:textField name="email" type="email" required="true" placeholder="usuario@empresa.com"
                                class="peer block w-full rounded-lg bg-slate-900 border-slate-600 text-white p-3 border 
                                       focus:ring-2 focus:ring-blue-500 outline-none
                                       valid:border-green-500 transition-all"/>
                        </div>

                        <div>
                            <label class="block text-xs font-medium text-slate-400 mb-1 uppercase">Teléfono Móvil <span class="text-red-500">*</span></label>
                            <div class="relative">
                                <i class="fas fa-phone absolute left-3 top-3.5 text-slate-500"></i>
                                <input type="tel" name="telefono" 
                                    maxlength="10" minlength="10" pattern="[0-9]{10}" required
                                    oninput="this.value = this.value.replace(/[^0-9]/g, '')"
                                    placeholder="10 dígitos"
                                    class="peer block w-full rounded-lg bg-slate-900 border-slate-600 text-white p-3 pl-10 border 
                                           focus:ring-2 focus:ring-blue-500 outline-none font-mono tracking-widest
                                           valid:border-green-500 valid:ring-1 valid:ring-green-500/30
                                           invalid:border-pink-500 transition-all"/>
                            </div>
                            <p class="mt-1 text-[10px] text-slate-500 peer-invalid:text-pink-500">Solo números. Exactamente 10 dígitos.</p>
                        </div>

                        <div>
                            <label class="block text-xs font-medium text-slate-400 mb-1 uppercase">Contraseña <span class="text-red-500">*</span></label>
                            <div class="relative">
                                <g:passwordField name="password" required="true" pattern="(?=.*\\d)(?=.*[A-Z]).{8,}" placeholder="••••••••"
                                    class="peer block w-full rounded-lg bg-slate-900 border-slate-600 text-white p-3 border 
                                           focus:ring-2 focus:ring-blue-500 outline-none
                                           valid:border-green-500 transition-all"/>
                                <i class="fas fa-lock absolute right-3 top-3.5 text-slate-500 peer-focus:text-blue-500"></i>
                            </div>
                            <p class="mt-1 text-[10px] text-slate-500">Min 8 chars, 1 Mayúscula, 1 Número.</p>
                        </div>
                    </div>
                </div>

                <div>
                    <h3 class="text-lg font-semibold text-white mb-4 border-b border-slate-700 pb-2 pt-4">
                        <i class="fas fa-briefcase text-blue-500 mr-2"></i> Perfil Técnico
                    </h3>

                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        
                        <div>
                            <label class="block text-xs font-medium text-slate-400 mb-1 uppercase">Años Exp. <span class="text-red-500">*</span></label>
                            <input type="number" name="anosExperiencia" min="0" max="50" required
                                oninput="this.value = this.value.replace(/[^0-9]/g, ''); if(this.value > 50) this.value = 50;"
                                class="peer block w-full rounded-lg bg-slate-900 border-slate-600 text-white p-3 border 
                                       focus:ring-2 focus:ring-blue-500 outline-none valid:border-green-500"/>
                        </div>

                        <div class="md:col-span-2">
                            <label class="block text-xs font-medium text-slate-400 mb-1 uppercase">Pretensión Salarial (MXN) <span class="text-red-500">*</span></label>
                            <div class="relative">
                                <span class="absolute left-3 top-3 text-slate-400 font-bold">$</span>
                                <input type="number" name="pretensionSalarial" min="1000" step="0.01" required
                                    class="peer block w-full rounded-lg bg-slate-900 border-slate-600 text-white p-3 pl-8 border 
                                           focus:ring-2 focus:ring-blue-500 outline-none valid:border-green-500"/>
                            </div>
                        </div>

                        <div>
                            <label class="block text-xs font-medium text-slate-400 mb-1 uppercase">Disponibilidad <span class="text-red-500">*</span></label>
                            <input type="date" name="fechaDisponibilidad" required
                                class="peer block w-full rounded-lg bg-slate-900 border-slate-600 text-white p-3 border 
                                       focus:ring-2 focus:ring-blue-500 outline-none valid:border-green-500 [color-scheme:dark]"/>
                        </div>

                        <div>
                            <label class="block text-xs font-medium text-slate-400 mb-1 uppercase">Modalidad <span class="text-red-500">*</span></label>
                            <g:select name="modalidad" from="${['Remoto', 'Híbrido', 'Presencial']}" 
                                noSelection="['':'- Seleccione -']" required="true"
                                class="block w-full rounded-lg bg-slate-900 border-slate-600 text-white p-3 border focus:ring-2 focus:ring-blue-500"/>
                        </div>

                        <div>
                            <label class="block text-xs font-medium text-slate-400 mb-1 uppercase">Departamento <span class="text-red-500">*</span></label>
                            <g:select name="departamento" from="${['Desarrollo', 'Infraestructura', 'QA', 'Ventas', 'RH']}" 
                                noSelection="['':'- Seleccione -']" required="true"
                                class="block w-full rounded-lg bg-slate-900 border-slate-600 text-white p-3 border focus:ring-2 focus:ring-blue-500"/>
                        </div>

                        <div class="md:col-span-3">
                            <label class="block text-xs font-medium text-slate-400 mb-1 uppercase">Stack Tecnológico <span class="text-red-500">*</span></label>
                            <g:select name="habilidades" from="${['Java', 'Groovy', 'Grails', 'Spring Boot', 'React', 'Angular', 'AWS', 'Docker']}" 
                                multiple="true" size="4" required="true"
                                class="block w-full rounded-lg bg-slate-900 border-slate-600 text-white p-2 border focus:ring-2 focus:ring-blue-500"/>
                            <p class="mt-1 text-[10px] text-slate-500">Mantén presionado Ctrl (Windows) o Cmd (Mac) para seleccionar múltiples opciones.</p>
                        </div>
                    </div>
                </div>

                <div>
                    <label class="block text-xs font-medium text-slate-400 mb-1 uppercase">Resumen Profesional</label>
                    <g:textArea name="biografia" rows="3" maxlength="2000" placeholder="Breve descripción de su perfil..."
                        class="block w-full rounded-lg bg-slate-900 border-slate-600 text-white p-3 border focus:ring-2 focus:ring-blue-500 placeholder-slate-600"/>
                </div>

                <div class="pt-2">
                    <label class="flex items-center space-x-3 cursor-pointer p-3 rounded hover:bg-slate-700/50 transition-colors">
                        <g:checkBox name="aceptaTerminos" required="true" class="w-5 h-5 rounded border-slate-500 bg-slate-700 text-blue-600 focus:ring-blue-500"/>
                        <span class="text-sm text-slate-300">
                            Confirmo que la información es real y acepto ser contactado. <span class="text-red-500">*</span>
                        </span>
                    </label>
                </div>

                <div class="pt-6 border-t border-slate-700">
                    <button type="submit" 
                        class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-3.5 rounded-lg shadow-lg transition-transform active:scale-95 flex justify-center items-center gap-2 group disabled:opacity-50 disabled:cursor-not-allowed">
                        <span>Enviar Postulación</span>
                        <i class="fas fa-paper-plane group-hover:translate-x-1 transition-transform"></i>
                    </button>
                </div>

            </g:form>
        </div>
    </div>

    <script>
        // 1. Mostrar Toast si hay mensaje Flash (Simulación de éxito)
        <g:if test="${flash.message}">
            Swal.fire({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 4000,
                timerProgressBar: true,
                icon: 'success',
                title: '¡Éxito!',
                text: '${flash.message}',
                background: '#1e293b',
                color: '#fff',
                iconColor: '#22c55e'
            });
        </g:if>

        // 2. Mostrar Alerta de Error si el Backend rechazó (Fallback)
        <g:hasErrors bean="${cmd}">
            Swal.fire({
                icon: 'error',
                title: 'Error de Validación',
                text: 'Por favor, corrige los campos marcados en rojo.',
                background: '#1e293b',
                color: '#fff',
                confirmButtonColor: '#ef4444'
            });
        </g:hasErrors>

        // 3. Validación Extra: Evitar envío si el formulario es inválido (aunque HTML5 ya lo hace)
        document.querySelector('form').addEventListener('submit', function(e) {
            if (!this.checkValidity()) {
                e.preventDefault();
                e.stopPropagation();
                Swal.fire({
                    toast: true, position: 'top-end', showConfirmButton: false, timer: 3000,
                    icon: 'warning', title: 'Campos incompletos', background: '#1e293b', color: '#fff'
                });
            }
        });
    </script>

</body>
</html>