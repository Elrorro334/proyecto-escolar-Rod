<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net; style-src 'self' 'unsafe-inline' https://cdnjs.cloudflare.com; font-src 'self' https://cdnjs.cloudflare.com;">
    <title>Formulario de Prueba</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <script>
        if (self !== top) { top.location = self.location; }
    </script>
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
            
            <g:form controller="form" action="simular" name="careerForm" class="space-y-8" 
                    useToken="true" autocomplete="off" novalidate="novalidate">

                <div class="space-y-6">
                    <h3 class="text-sm font-bold text-blue-500 uppercase tracking-widest border-b border-slate-800 pb-2">Identidad</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-x-8 gap-y-6">
                        
                        <div class="group relative">
                            <label class="block text-xs font-bold text-slate-500 mb-2 uppercase">Nombre Completo *</label>
                            <g:textField name="nombre" id="nombre" value="${cmd?.nombre?.encodeAsHTML()}" 
                                maxlength="60" pattern="[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]{5,60}"
                                class="w-full rounded-lg bg-[#0f1014] border border-slate-700 text-white p-3 focus:outline-none transition-all"/>
                            <i id="icon-nombre" class="fas fa-circle absolute right-3 top-4 text-slate-700 text-xs transition-colors"></i>
                            <small class="text-[10px] text-slate-600 mt-1">Min 5 letras, solo texto</small>
                        </div>

                        <div class="group relative">
                            <label class="block text-xs font-bold text-slate-500 mb-2 uppercase">Email Corporativo *</label>
                            <g:textField name="email" id="email" value="${cmd?.email?.encodeAsHTML()}" 
                                maxlength="80" type="email" autocomplete="off"
                                class="w-full rounded-lg bg-[#0f1014] border border-slate-700 text-white p-3 focus:outline-none transition-all"/>
                            <i id="icon-email" class="fas fa-circle absolute right-3 top-4 text-slate-700 text-xs transition-colors"></i>
                        </div>

                        <div class="group relative">
                            <label class="block text-xs font-bold text-slate-500 mb-2 uppercase">Teléfono Móvil *</label>
                            <input type="tel" name="telefono" id="telefono" value="${cmd?.telefono?.encodeAsHTML()}" 
                                maxlength="10" placeholder="10 DÍGITOS" pattern="[0-9]{10}" inputmode="numeric"
                                class="w-full rounded-lg bg-[#0f1014] border border-slate-700 text-white p-3 focus:outline-none transition-all font-mono tracking-widest"/>
                            <i id="icon-telefono" class="fas fa-circle absolute right-3 top-4 text-slate-700 text-xs transition-colors"></i>
                        </div>

                        <div class="group relative">
                            <label class="block text-xs font-bold text-slate-500 mb-2 uppercase">Contraseña *</label>
                            <g:passwordField name="password" id="password" placeholder="Min 8 car, 1 Mayus, 1 Num"
                                autocomplete="new-password" maxlength="30"
                                oncopy="return false" onpaste="return false" oncut="return false"
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
                            <input type="text" name="anosExperiencia" id="anosExperiencia" value="${cmd?.anosExperiencia?.encodeAsHTML()}" 
                                maxlength="2" inputmode="numeric" pattern="\d*"
                                class="w-full rounded-lg bg-[#0f1014] border border-slate-700 text-white p-3 focus:outline-none transition-all"/>
                            <i id="icon-anosExperiencia" class="fas fa-circle absolute right-3 top-4 text-slate-700 text-xs transition-colors"></i>
                        </div>
                        
                        <div class="md:col-span-2 group relative">
                            <label class="block text-xs font-bold text-slate-500 mb-2 uppercase">Pretensión Salarial (MXN)</label>
                            <div class="relative">
                                <span class="absolute left-3 top-3 text-slate-500 font-bold">$</span>
                                <input type="text" name="pretensionSalarial" id="pretensionSalarial" value="${cmd?.pretensionSalarial?.encodeAsHTML()}" 
                                    maxlength="9" inputmode="decimal"
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
                                value="${cmd?.modalidad?.encodeAsHTML()}" noSelection="['':'- SELECCIONE -']" 
                                class="w-full rounded-lg bg-[#0f1014] border border-slate-700 text-white p-3 focus:outline-none transition-all"/>
                            <i id="icon-modalidad" class="fas fa-circle absolute right-8 top-4 text-slate-700 text-xs transition-colors"></i>
                        </div>
                        <div class="group relative">
                            <label class="block text-xs font-bold text-slate-500 mb-2 uppercase">Departamento *</label>
                            <g:select name="departamento" id="departamento" from="${['Desarrollo', 'Infraestructura', 'QA', 'Ventas', 'RH']}" 
                                value="${cmd?.departamento?.encodeAsHTML()}" noSelection="['':'- SELECCIONE -']" 
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
            
            // CONFIGURACIÓN DE ALERTAS
            const Toast = Swal.mixin({
                toast: true, position: 'top-end', showConfirmButton: false, timer: 4000,
                background: '#1e293b', color: '#fff'
            });

            const getEl = (id) => document.getElementById(id);

            // VALIDACIONES RIGUROSAS
            const validators = {
                nombre: (v) => v.trim().length >= 5 && v.length <= 60 && /^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$/.test(v) && !/<[^>]*>/.test(v),
                email: (v) => v.length <= 80 && /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/.test(v),
                telefono: (v) => v.length === 10 && /^[0-9]{10}$/.test(v),
                password: (v) => v.length >= 8 && v.length <= 30 && /^(?=.*\d)(?=.*[A-Z]).{8,}$/.test(v),
                anosExperiencia: (v) => v !== '' && !isNaN(v) && parseInt(v) >= 0 && parseInt(v) <= 50,
                pretensionSalarial: (v) => v !== '' && !isNaN(v) && parseFloat(v) >= 1000.00 && parseFloat(v) < 10000000,
                modalidad: (v) => ['Remoto', 'Híbrido', 'Presencial'].includes(v),
                departamento: (v) => ['Desarrollo', 'Infraestructura', 'QA', 'Ventas', 'RH'].includes(v),
                habilidades: () => getEl('habilidades').selectedOptions.length >= 1,
                aceptaTerminos: () => getEl('aceptaTerminos').checked
            };

            // FUNCION VISUAL DE ESTADO
            function setStatus(id, isValid) {
                const input = getEl(id);
                const icon = getEl('icon-' + id);
                if (!input) return;

                input.classList.remove('border-slate-700', 'border-red-500', 'border-green-500');
                if (isValid) {
                    input.classList.add('border-green-500');
                    if (icon) icon.className = 'fas fa-check-circle absolute right-3 top-4 text-green-500 text-xs transition-colors';
                } else if ((input.value !== '' && input.type !== 'checkbox') || id === 'aceptaTerminos') {
                    input.classList.add('border-red-500');
                    if (icon) icon.className = 'fas fa-times-circle absolute right-3 top-4 text-red-500 text-xs transition-colors';
                } else {
                    input.classList.add('border-slate-700');
                    if (icon) icon.className = 'fas fa-circle absolute right-3 top-4 text-slate-700 text-xs transition-colors';
                }
            }

            // LISTENERS DE SANITIZACIÓN (Anti-Inyección en tiempo real)
            const inputs = {
                nombre: getEl('nombre'),
                tel: getEl('telefono'),
                exp: getEl('anosExperiencia'),
                sal: getEl('pretensionSalarial'),
                pass: getEl('password')
            };

            inputs.nombre.addEventListener('input', (e) => {
                e.target.value = e.target.value.replace(/[^a-zA-ZáéíóúÁÉÍÓÚñÑ\s]/g, ''); 
                setStatus('nombre', validators.nombre(e.target.value));
            });

            [inputs.tel, inputs.exp, inputs.sal].forEach(el => {
                el.addEventListener('input', (e) => {
                    e.target.value = e.target.value.replace(/\D/g, ''); 
                    if(el.id === 'telefono') setStatus('telefono', validators.telefono(e.target.value));
                    if(el.id === 'anosExperiencia') setStatus('anosExperiencia', validators.anosExperiencia(e.target.value));
                    if(el.id === 'pretensionSalarial') setStatus('pretensionSalarial', validators.pretensionSalarial(e.target.value));
                });
            });

            inputs.pass.addEventListener('input', (e) => {
                if(e.target.value.includes(' ')) e.target.value = e.target.value.replace(/\s/g, '');
                setStatus('password', validators.password(e.target.value));
            });

            // RESTO DE CAMPOS
            ['email'].forEach(id => getEl(id).addEventListener('input', (e) => setStatus(id, validators[id](e.target.value))));
            ['modalidad', 'departamento'].forEach(id => getEl(id).addEventListener('change', (e) => setStatus(id, validators[id](e.target.value))));
            getEl('habilidades').addEventListener('change', () => setStatus('habilidades', validators.habilidades()));
            getEl('aceptaTerminos').addEventListener('change', () => setStatus('aceptaTerminos', validators.aceptaTerminos()));

            // INTERCEPTOR (GATEKEEPER)
            document.getElementById('careerForm').addEventListener('submit', function(e) {
                e.preventDefault(); 
                let isValid = true;
                
                Object.keys(validators).forEach(key => {
                    let fieldValid = (key === 'habilidades' || key === 'aceptaTerminos') ? validators[key]() : validators[key](getEl(key).value);
                    setStatus(key, fieldValid);
                    if (!fieldValid) isValid = false;
                });

                if (!isValid) {
                    Toast.fire({ icon: 'error', title: 'Acceso Denegado', text: 'Datos inválidos o inseguros detectados.' });
                } else {
                    const btn = getEl('btnSubmit');
                    btn.disabled = true;
                    btn.innerHTML = '<i class="fas fa-lock mr-2"></i>ENCRIPTANDO...';
                    this.submit(); 
                }
            });

            // FEEDBACK DEL BACKEND
            <g:if test="${flash.message}">
                Toast.fire({ icon: 'success', title: 'Éxito', text: '${flash.message?.encodeAsJavaScript()}' });
            </g:if>
            <g:hasErrors bean="${cmd}">
                Toast.fire({ icon: 'error', title: 'Error de Seguridad', text: 'El servidor rechazó la solicitud.' });
            </g:hasErrors>
        });
    </script>
</body>
</html>