<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Inicio - Proyecto Escolar</title>
</head>
<body>

    <nav class="flex mb-8 text-slate-400 text-sm" aria-label="Breadcrumb">
        <ol class="inline-flex items-center space-x-1 md:space-x-3">
            <li class="inline-flex items-center">
                <a href="${createLink(uri: '/')}" class="inline-flex items-center hover:text-brand-accent transition-colors">
                    <i class="fas fa-home mr-2"></i>
                    Inicio
                </a>
            </li>
            <li aria-current="page">
                <div class="flex items-center">
                </div>
            </li>
        </ol>
    </nav>

    <div class="text-center mb-10">
        <h1 class="text-3xl md:text-4xl font-bold text-white mb-2 tracking-tight">Hola Mundo</h1>
    </div>

    <div class="max-w-lg mx-auto bg-brand-panel rounded-xl shadow-2xl border border-slate-700 overflow-hidden">
        
        <div class="h-2 bg-gradient-to-r from-blue-600 to-indigo-600 w-full"></div>

        <div class="p-8">
            <g:form controller="main" action="save" method="POST" class="space-y-6">
                
                <div>
                    <label for="nombre" class="block text-sm font-medium text-slate-300 mb-2">Nombre Completo</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-user text-slate-500"></i>
                        </div>
                        <input type="text" id="nombre" name="nombre" 
                               value="${nombre}" 
                               class="bg-slate-900 border border-slate-700 text-white text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-3 placeholder-slate-600 transition-all shadow-sm" 
                               placeholder="Ej. Rodrigo Sánchez" required>
                    </div>
                </div>

                <div class="flex justify-center my-4 transform scale-90 md:scale-100 origin-center">
                    <div class="g-recaptcha" data-sitekey="6LcxNUMsAAAAAJCF18aZ7IRp8F_FEbDCAr-rgChp" data-theme="dark"></div>
                </div>

                <button type="submit" class="w-full text-white bg-blue-600 hover:bg-blue-700 focus:ring-4 focus:ring-blue-800 font-medium rounded-lg text-sm px-5 py-3 text-center inline-flex items-center justify-center transition-all shadow-lg hover:shadow-blue-500/30">
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

    <script>
        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
            background: '#1e293b', /* Slate 800 */
            color: '#f8fafc',      /* Texto blanco */
            didOpen: (toast) => {
                toast.addEventListener('mouseenter', Swal.stopTimer)
                toast.addEventListener('mouseleave', Swal.resumeTimer)
            }
        });

        <g:if test="${flash.error || error}">
            Toast.fire({ icon: 'error', title: '${flash.error ?: error}' });
        </g:if>
        
        <g:if test="${flash.message}">
            Toast.fire({ icon: 'success', title: '${flash.message}' });
        </g:if>
    </script>

</body>
</html>