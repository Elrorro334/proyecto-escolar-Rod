<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net; style-src 'self' 'unsafe-inline' https://cdnjs.cloudflare.com; img-src 'self' data: blob:; font-src 'self' https://cdnjs.cloudflare.com;">
    <title>Galería - Proyecto Escolar</title>
    
    <script>if(self !== top) top.location = self.location;</script>
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
            <li class="text-blue-500 font-medium">Galería Multimedia</li>
        </ol>
    </nav>

    <div class="mb-6">
        <h2 class="text-2xl font-bold text-white tracking-tight">Galería Multimedia</h2>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">

        <div class="lg:col-span-1">
            <div class="bg-slate-800 rounded-lg border border-slate-700 shadow-lg p-5">
                
                <div class="border-b border-slate-700 pb-3 mb-4">
                    <h3 class="text-white font-semibold flex items-center gap-2">
                        <i class="fas fa-cloud-upload-alt text-blue-500"></i> Subir Nueva Foto
                    </h3>
                </div>

                <g:uploadForm controller="imagen" action="subir" name="uploadForm" useToken="true" onsubmit="return validateSubmit()">
                    
                    <div class="mb-4">
                        <label class="block text-xs font-medium text-slate-400 mb-2 uppercase">Seleccionar Archivo</label>
                        
                        <input type="file" id="fotoInput" name="fotoPayload" 
                               class="block w-full text-sm text-slate-300
                                      file:mr-4 file:py-2 file:px-4
                                      file:rounded-full file:border-0
                                      file:text-xs file:font-semibold
                                      file:bg-blue-600 file:text-white
                                      file:cursor-pointer hover:file:bg-blue-700
                                      bg-slate-900 border border-slate-600 rounded-lg cursor-pointer focus:outline-none"
                               accept="image/png, image/jpeg, image/gif" required />
                               
                        <p class="mt-1 text-[10px] text-slate-500">Máx 5MB. Formatos: JPG, PNG, GIF.</p>
                        <p id="errorMsg" class="mt-1 text-xs text-red-500 font-bold hidden"></p>
                    </div>

                    <div id="contenedorPreview" class="mb-4 border-2 border-dashed border-slate-600 bg-slate-900/50 rounded-lg min-h-[200px] flex flex-col items-center justify-center relative overflow-hidden transition-all">
                        
                        <div id="placeholderContent" class="text-center p-4">
                            <i id="previewIcon" class="fas fa-image text-4xl text-slate-600 mb-2"></i>
                            <p id="previewText" class="text-xs text-slate-500">La vista previa aparecerá aquí</p>
                        </div>

                        <img id="imagenPrevia" src="#" alt="Preview" class="hidden w-full h-auto object-cover max-h-[250px] rounded-md shadow-md">
                    </div>

                    <button type="submit" id="btnSubmit" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-2.5 rounded-lg shadow-md transition-all flex justify-center items-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed">
                        <i class="fas fa-save"></i> Guardar Imagen
                    </button>

                </g:uploadForm>
            </div>
        </div>

        <div class="lg:col-span-2">
            <div class="bg-slate-800 rounded-lg border border-slate-700 shadow-lg p-1 overflow-hidden h-full">
                
                <g:if test="${listaImagenes}">
                    <div id="carruselBD" class="carousel slide h-full" data-bs-ride="carousel">
                        
                        <div class="carousel-indicators">
                            <g:each in="${listaImagenes}" var="img" status="i">
                                <button type="button" data-bs-target="#carruselBD" data-bs-slide-to="${i}" 
                                        class="${i == 0 ? 'active' : ''}" aria-current="true"></button>
                            </g:each>
                        </div>

                        <div class="carousel-inner rounded-lg overflow-hidden relative">
                            <g:each in="${listaImagenes}" var="img" status="i">
                                <div class="carousel-item ${i == 0 ? 'active' : ''} relative">
                                    
                                    <a href="${createLink(controller: 'imagen', action: 'eliminar', id: img.id)}" 
                                       class="absolute top-4 right-4 z-20 bg-red-600/80 hover:bg-red-600 text-white w-10 h-10 rounded-full flex items-center justify-center shadow-lg backdrop-blur-sm transition-transform hover:scale-110"
                                       onclick="return confirm('¿Confirma eliminar la imagen seleccionada?');"
                                       title="Eliminar">
                                        <i class="fas fa-trash-alt text-sm"></i>
                                    </a>

                                    <img src="${createLink(controller: 'imagen', action: 'renderizar', id: img.id)}" 
                                         class="d-block w-100 object-cover" 
                                         style="height: 500px; width: 100%; object-fit: cover;"
                                         alt="${img.nombreOriginal?.encodeAsHTML()}">
                                    
                                    
                                </div>
                            </g:each>
                        </div>

                        <button class="carousel-control-prev" type="button" data-bs-target="#carruselBD" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon bg-slate-900/50 rounded-full p-3" aria-hidden="true"></span>
                            <span class="visually-hidden">Anterior</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carruselBD" data-bs-slide="next">
                            <span class="carousel-control-next-icon bg-slate-900/50 rounded-full p-3" aria-hidden="true"></span>
                            <span class="visually-hidden">Siguiente</span>
                        </button>
                    </div>
                </g:if>
                <g:else>
                    <div class="flex flex-col items-center justify-center h-full py-20 text-center">
                        <div class="bg-slate-900 p-6 rounded-full border border-slate-700 mb-4">
                            <i class="fas fa-images text-5xl text-slate-600"></i>
                        </div>
                        <h4 class="text-white font-bold text-lg">Galería Vacía</h4>
                        <p class="text-slate-500 text-sm max-w-xs mt-2">Usa el formulario seguro para subir contenido.</p>
                    </div>
                </g:else>

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const fileInput = document.getElementById('fotoInput');
            const btnSubmit = document.getElementById('btnSubmit');
            let isFileValid = false;

            // --- SEGURIDAD 7: VERIFICACIÓN DE MAGIC BYTES (CRÍTICO) ---
            fileInput.addEventListener('change', function(event) {
                const file = event.target.files[0];
                const errorMsg = document.getElementById('errorMsg');
                
                // Reset UI
                resetPreview();
                errorMsg.classList.add('hidden');
                btnSubmit.disabled = true;
                isFileValid = false;

                if (!file) return;

                // 1. Validación de Tamaño (5MB)
                if (file.size > 5 * 1024 * 1024) {
                    showError("El archivo excede el límite de 5MB.");
                    fileInput.value = ""; // Limpiar input
                    return;
                }

                // 2. Validación Binaria de Header (Magic Bytes)
                const reader = new FileReader();
                reader.onloadend = function(e) {
                    const arr = (new Uint8Array(e.target.result)).subarray(0, 4);
                    let header = "";
                    for(let i = 0; i < arr.length; i++) {
                        header += arr[i].toString(16);
                    }
                    
                    // Firmas Hexadecimales conocidas
                    let type = "unknown";
                    if (header.startsWith("89504e47")) type = "image/png";
                    else if (header.startsWith("ffd8ff")) type = "image/jpeg";
                    else if (header.startsWith("47494638")) type = "image/gif";
                    
                    if (type === "unknown") {
                        showError("Formato de archivo inválido o corrupto (Firma desconocida).");
                        fileInput.value = "";
                    } else {
                        // Éxito: Mostrar preview
                        isFileValid = true;
                        btnSubmit.disabled = false;
                        showPreview(file);
                    }
                };
                reader.readAsArrayBuffer(file); // Leemos binario, no URL data aún
            });

            function showError(msg) {
                const errorMsg = document.getElementById('errorMsg');
                errorMsg.textContent = msg;
                errorMsg.classList.remove('hidden');
                
                const box = document.getElementById('contenedorPreview');
                box.classList.add('border-red-500/50', 'bg-red-900/10');
            }

            function resetPreview() {
                document.getElementById('placeholderContent').style.display = 'block';
                document.getElementById('imagenPrevia').classList.add('hidden');
                document.getElementById('imagenPrevia').src = '#';
                const box = document.getElementById('contenedorPreview');
                box.classList.remove('border-green-500/50', 'bg-green-900/10', 'border-red-500/50', 'bg-red-900/10');
                box.classList.add('border-slate-600', 'bg-slate-900/50');
            }

            function showPreview(file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('placeholderContent').style.display = 'none';
                    const img = document.getElementById('imagenPrevia');
                    img.src = e.target.result;
                    img.classList.remove('hidden');
                    
                    const box = document.getElementById('contenedorPreview');
                    box.classList.remove('border-slate-600', 'bg-slate-900/50');
                    box.classList.add('border-green-500/50', 'bg-green-900/10');
                };
                reader.readAsDataURL(file); // Ahora sí leemos para mostrar
            }

            // --- TOASTS ---
            const Toast = Swal.mixin({
                toast: true, position: 'top-end', showConfirmButton: false, timer: 3000,
                timerProgressBar: true, background: '#1e293b', color: '#fff'
            });

            <g:if test="${flash.message}">
                Toast.fire({ icon: 'success', title: '${flash.message?.encodeAsJavaScript()}', iconColor: '#22c55e' });
            </g:if>
            <g:if test="${flash.error}">
                Toast.fire({ icon: 'error', title: '${flash.error?.encodeAsJavaScript()}', iconColor: '#ef4444' });
            </g:if>
        });

        // Interceptor final
        function validateSubmit() {
            const btn = document.getElementById('btnSubmit');
            if (btn.disabled) return false;
            
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Subiendo...';
            btn.disabled = true; // Prevenir doble submit
            return true;
        }
    </script>

</body>
</html>