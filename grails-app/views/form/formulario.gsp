<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Formulario de Prueba</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

    <nav class="flex mb-6 text-slate-400 text-sm font-medium w-full" aria-label="Breadcrumb">
        <ol class="inline-flex items-center space-x-2">
            <li><a href="${createLink(uri: '/')}" class="hover:text-blue-500 transition-colors flex items-center"><i class="fas fa-home mr-2 text-xs"></i> Inicio</a></li>
            <li class="flex items-center"><i class="fas fa-chevron-right text-[10px] mx-2 text-slate-600"></i><span class="text-blue-500 font-semibold">Formulario de Prueba</span></li>
        </ol>
    </nav>

    <div class="mb-8 border-l-4 border-blue-600 pl-4">
        <h2 class="text-2xl font-bold text-white tracking-tight uppercase">Formulario de Prueba</h2>
    </div>

    <div class="bg-[#1a1c23] rounded-xl shadow-2xl border border-slate-800 overflow-hidden max-w-4xl mx-auto">
        <div class="p-6 md:p-10">
            
            <g:form controller="form" action="simular" name="careerForm" class="space-y-8" novalidate="novalidate">

                <div class="space-y-6">
                    <h3 class="text-sm font-bold text-blue-500 uppercase tracking-widest border-b border-slate-800 pb-2">Identidad</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-x-8 gap-y-6">
                        
                        <div class="group relative">
                            <label class="block text-xs font-bold text-slate-500 mb-2 uppercase">Nombre Completo *</label>
                            <g:textField name="nombre" id="nombre" value="${cmd?.nombre}" 
                                class="w-full rounded-lg bg-[#0f1014] border border-slate-700 text-white p-3 focus:outline-none transition-all"/>
                            <i id="icon-nombre" class="fas fa-circle absolute right-3 top-4 text-slate-700 text-xs transition-colors"></i>
                            <small class="text-[10px] text-slate-600 mt-1">Min 5 letras, solo texto</small>
                        </div>

                        <div class="group relative">
                            <label class="block text-xs font-bold text-slate-500 mb-2 uppercase">Email Corporativo *</label>
                            <g:textField name="email" id="email" value="${cmd?.email}" 
                                class="w-full rounded-lg bg-[#0f1014] border border-slate-700 text-white p-3 focus:outline-none transition-all"/>
                            <i id="icon-email" class="fas fa-circle absolute right-3 top-4 text-slate-700 text-xs transition-colors"></i>
                        </div>

                        <div class="group relative">
                            <label class="block text-xs font-bold text-slate-500 mb-2 uppercase">Teléfono Móvil *</label>
                            <input type="text" name="telefono" id="telefono" value="${cmd?.telefono}" maxlength="10" placeholder="10 DÍGITOS"
                                class="w-full rounded-lg bg-[#0f1014] border border-slate-700 text-white p-3 focus:outline-none transition-all font-mono tracking-widest"/>
                            <i id="icon-telefono" class="fas fa-circle absolute right-3 top-4 text-slate-700 text-xs transition-colors"></i>
                        </div>

                        <div class="group relative">
                            <label class="block text-xs font-bold text-slate-500 mb-2 uppercase">Contraseña *</label>
                            <g:passwordField name="password" id="password" placeholder="Min 8 car, 1 Mayus, 1 Num"
                                class="w-full rounded-lg bg-[#0f1014] border border-slate-700 text-white p-3 focus:outline-none transition-all"/>
                            <i id="icon-password" class="fas fa-circle absolute right-3 top-4 text-slate-700 text-xs transition-colors"></i>
                        </div>
                    </div>
                </div>

                <div class="space-y-6">
                    <h3 class="text-sm font-bold text-blue-500 uppercase tracking-widest border-b border-slate-800 pb-2">Perfil Técnico</h3>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        
                        <div class="group relative">
                            <label class="block text-xs font-bold text-slate-500 mb-2 uppercase">Años Exp.</label>
                            <input type="text" name="anosExperiencia" id="anosExperiencia" value="${cmd?.anosExperiencia}" maxlength="2"
                                class="w-full rounded-lg bg-[#0f1014] border border-slate-700 text-white p-3 focus:outline-none transition-all"/>
                            <i id="icon-anosExperiencia" class="fas fa-circle absolute right-3 top-4 text-slate-700 text-xs transition-colors"></i>
                        </div>
                        
                        <div class="md:col-span-2 group relative">
                            <label class="block text-xs font-bold text-slate-500 mb-2 uppercase">Pretensión Salarial (MXN)</label>
                            <div class="relative">
                                <span class="absolute left-3 top-3 text-slate-500 font-bold">$</span>
                                <input type="text" name="pretensionSalarial" id="pretensionSalarial" value="${cmd?.pretensionSalarial}" maxlength="9"
                                    class="w-full rounded-lg bg-[#0f1014] border border-slate-700 text-white p-3 pl-8 focus:outline-none transition-all"/>
                                <i id="icon-pretensionSalarial" class="fas fa-circle absolute right-3 top-4 text-slate-700 text-xs transition-colors"></i>
                            </div>
                            <small class="text-[10px] text-slate-600 mt-1">Mínimo $1,000.00</small>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="group relative">
                            <label class="block text-xs font-bold text-slate-500 mb-2 uppercase">Modalidad *</label>
                            <g:select name="modalidad" id="modalidad" from="${['Remoto', 'Híbrido', 'Presencial']}" 
                                value="${cmd?.modalidad}" noSelection="['':'- SELECCIONE -']" 
                                class="w-full rounded-lg bg-[#0f1014] border border-slate-700 text-white p-3 focus:outline-none transition-all"/>
                            <i id="icon-modalidad" class="fas fa-circle absolute right-8 top-4 text-slate-700 text-xs transition-colors"></i>
                        </div>
                        <div class="group relative">
                            <label class="block text-xs font-bold text-slate-500 mb-2 uppercase">Departamento *</label>
                            <g:select name="departamento" id="departamento" from="${['Desarrollo', 'Infraestructura', 'QA', 'Ventas', 'RH']}" 
                                value="${cmd?.departamento}" noSelection="['':'- SELECCIONE -']" 
                                class="w-full rounded-lg bg-[#0f1014] border border-slate-700 text-white p-3 focus:outline-none transition-all"/>
                            <i id="icon-departamento" class="fas fa-circle absolute right-8 top-4 text-slate-700 text-xs transition-colors"></i>
                        </div>
                    </div>

                    <div class="group relative">
                        <label class="block text-xs font-bold text-slate-500 mb-2 uppercase">Stack Tecnológico *</label>
                        <g:select name="habilidades" id="habilidades" 
                            from="${['Java', 'Groovy', 'Grails', 'Spring Boot', 'React', 'Angular', 'AWS', 'Docker']}" 
                            value="${cmd?.habilidades}" multiple="true" size="4" 
                            class="w-full rounded-lg bg-[#0f1014] border border-slate-700 text-white p-2 focus:outline-none transition-all"/>
                        <small class="text-[10px] text-slate-600">Ctrl + Click para seleccionar (Mínimo 1)</small>
                    </div>
                </div>

                <div class="pt-6 border-t border-slate-800">
                    <label class="flex items-center space-x-3 cursor-pointer group mb-6">
                        <g:checkBox name="aceptaTerminos" id="aceptaTerminos" value="${cmd?.aceptaTerminos}" 
                            class="w-5 h-5 rounded border-slate-700 bg-slate-900 text-blue-600 focus:ring-blue-500"/>
                        <span class="text-xs text-slate-400 group-hover:text-white transition-colors uppercase font-bold tracking-tighter">
                            Declaro que la información es real *
                        </span>
                    </label>

                    <button type="submit" id="btnSubmit" 
                        class="w-full bg-blue-600 hover:bg-blue-500 text-white font-black py-4 rounded-lg shadow-xl uppercase tracking-widest text-sm transition-all disabled:opacity-50 disabled:cursor-not-allowed">
                        Enviar Postulación
                    </button>
                </div>

            </g:form>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            
            // --- CONFIGURACIÓN TOAST ---
            const Toast = Swal.mixin({
                toast: true, position: 'top-end', showConfirmButton: false, timer: 4000,
                background: '#1e293b', color: '#fff'
            });

            // --- REFERENCIAS AL DOM ---
            const getEl = (id) => document.getElementById(id);

            // --- REGLAS DE VALIDACIÓN (Espejo del Command Object) ---
            const validators = {
                nombre: (v) => v.trim().length >= 5 && v.length <= 60 && /^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$/.test(v),
                email: (v) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v),
                telefono: (v) => v.length === 10 && /^[0-9]{10}$/.test(v),
                password: (v) => v.length >= 8 && v.length <= 30 && /^(?=.*\d)(?=.*[A-Z]).{8,}$/.test(v),
                anosExperiencia: (v) => v !== '' && !isNaN(v) && parseInt(v) >= 0 && parseInt(v) <= 50,
                pretensionSalarial: (v) => v !== '' && !isNaN(v) && parseFloat(v) >= 1000.00,
                modalidad: (v) => v !== '',
                departamento: (v) => v !== '',
                habilidades: () => getEl('habilidades').selectedOptions.length >= 1,
                aceptaTerminos: () => getEl('aceptaTerminos').checked
            };

            // --- FUNCIÓN DE PINTADO (VERDE/ROJO) ---
            function setStatus(id, isValid) {
                const input = getEl(id);
                const icon = getEl('icon-' + id);
                if (!input) return;

                input.classList.remove('border-slate-700', 'border-red-500', 'border-green-500');
                
                if (isValid) {
                    input.classList.add('border-green-500');
                    if (icon) icon.className = 'fas fa-check-circle absolute right-3 top-4 text-green-500 text-xs transition-colors';
                } else if ((input.value !== '' && input.type !== 'checkbox') || id === 'aceptaTerminos') {
                    // Solo marca rojo si hay texto escrito o es el checkbox al intentar enviar
                    input.classList.add('border-red-500');
                    if (icon) icon.className = 'fas fa-times-circle absolute right-3 top-4 text-red-500 text-xs transition-colors';
                } else {
                    input.classList.add('border-slate-700');
                    if (icon) icon.className = 'fas fa-circle absolute right-3 top-4 text-slate-700 text-xs transition-colors';
                }
            }

            // --- LISTENERS DE LIMPIEZA (INPUT MASKING) ---
            const inputs = {
                nombre: getEl('nombre'),
                tel: getEl('telefono'),
                exp: getEl('anosExperiencia'),
                sal: getEl('pretensionSalarial')
            };

            // Nombre: Solo letras
            inputs.nombre.addEventListener('input', (e) => {
                e.target.value = e.target.value.replace(/[^a-zA-ZáéíóúÁÉÍÓÚñÑ\s]/g, '');
                setStatus('nombre', validators.nombre(e.target.value));
            });

            // Numéricos: Solo números
            [inputs.tel, inputs.exp, inputs.sal].forEach(el => {
                el.addEventListener('input', (e) => {
                    e.target.value = e.target.value.replace(/\D/g, ''); // Borra todo lo que no sea dígito
                    // Actualiza estado visual
                    if(el.id === 'telefono') setStatus('telefono', validators.telefono(e.target.value));
                    if(el.id === 'anosExperiencia') setStatus('anosExperiencia', validators.anosExperiencia(e.target.value));
                    if(el.id === 'pretensionSalarial') setStatus('pretensionSalarial', validators.pretensionSalarial(e.target.value));
                });
            });

            // Resto de campos
            ['email', 'password'].forEach(id => {
                getEl(id).addEventListener('input', (e) => setStatus(id, validators[id](e.target.value)));
            });

            ['modalidad', 'departamento'].forEach(id => {
                getEl(id).addEventListener('change', (e) => setStatus(id, validators[id](e.target.value)));
            });

            getEl('habilidades').addEventListener('change', () => setStatus('habilidades', validators.habilidades()));
            getEl('aceptaTerminos').addEventListener('change', () => setStatus('aceptaTerminos', validators.aceptaTerminos()));

            // --- INTERCEPTOR DE ENVÍO (GATEKEEPER) ---
            document.getElementById('careerForm').addEventListener('submit', function(e) {
                e.preventDefault(); // Detiene envío nativo
                
                let isValid = true;
                let firstError = null;
                
                // Ejecuta todas las validaciones
                Object.keys(validators).forEach(key => {
                    let val = null;
                    if(key !== 'habilidades' && key !== 'aceptaTerminos') val = getEl(key).value;
                    
                    const fieldValid = (key === 'habilidades' || key === 'aceptaTerminos') ? validators[key]() : validators[key](val);
                    
                    setStatus(key, fieldValid); // Pinta rojo si falla
                    
                    if (!fieldValid) {
                        isValid = false;
                        if (!firstError) firstError = key;
                    }
                });

                if (!isValid) {
                    Toast.fire({ icon: 'error', title: 'Datos Inválidos', text: 'Corrige los campos marcados en rojo' });
                    // Enfocar primer error (si es input simple)
                    const errEl = getEl(firstError);
                    if(errEl && errEl.focus) errEl.focus();
                } else {
                    const btn = getEl('btnSubmit');
                    btn.disabled = true;
                    btn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>ENVIANDO...';
                    this.submit(); // Envía al controlador
                }
            });

            // --- RESPUESTAS DEL CONTROLLER (FLASH/CMD) ---
            <g:if test="${flash.message}">
                Toast.fire({ icon: 'success', title: 'Éxito', text: '${flash.message}' });
            </g:if>

            <g:hasErrors bean="${cmd}">
                Toast.fire({ icon: 'error', title: 'Error Backend', text: 'Datos rechazados por el servidor' });
                // Aquí podrías iterar los errores del bean si quisieras ser más específico
            </g:hasErrors>
        });
    </script>
</body>
</html>