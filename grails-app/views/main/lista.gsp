<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Lista - Rodnix</title>
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

    <div class="flex justify-between items-center mb-6 w-full">
        <h2 class="text-xl font-bold text-white">Registros existentes</h2>
        <a href="${createLink(controller: 'main', action: 'index')}" 
           class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg text-sm font-medium shadow-sm transition-colors">
            <i class="fas fa-plus"></i> Nuevo
        </a>
    </div>

    <div class="w-full max-w-full bg-slate-800 rounded-lg border border-slate-700 overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full text-sm text-left text-slate-300">
                <thead class="text-xs text-slate-400 uppercase bg-slate-900/50 border-b border-slate-700">
                    <tr>
                        <th class="px-4 py-3 whitespace-nowrap w-1/3">Fecha</th>
                        <th class="px-4 py-3">Nombre Registrado</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-700">
                    <g:if test="${prospectos}">
                        <g:each in="${prospectos}" var="p">
                            <tr class="hover:bg-slate-700/30 transition-colors">
                                <td class="px-4 py-3 whitespace-nowrap text-blue-400 font-mono text-xs">
                                    <g:formatDate date="${p.fechaRegistro}" format="dd/MM HH:mm"/>
                                </td>
                                <td class="px-4 py-3 text-white break-all">
                                    ${p.nombre}
                                </td>
                            </tr>
                        </g:each>
                    </g:if>
                    <g:else>
                        <tr>
                            <td colspan="2" class="px-4 py-8 text-center text-slate-500">
                                No hay datos registrados aún.
                            </td>
                        </tr>
                    </g:else>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        <g:if test="${flash.message}">
            Swal.fire({
                toast: true, position: 'top-end', showConfirmButton: false, timer: 3000,
                icon: 'success', title: '${flash.message}',
                background: '#1e293b', color: '#fff', iconColor: '#22c55e'
            });
        </g:if>
    </script>

</body>
</html>