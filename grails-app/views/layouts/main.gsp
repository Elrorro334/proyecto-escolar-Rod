<!doctype html>
<html lang="es" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title><g:layoutTitle default="Proyecto Escolar"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    
    <link rel="icon" href="https://rodnix.com.mx/images/logoRODNIX.jpg" type="image/x-icon" />

    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['Montserrat', 'sans-serif'],
                    },
                    colors: {
                        brand: {
                            dark: '#0f172a',   /* Slate 900 */
                            panel: '#1e293b',  /* Slate 800 */
                            text: '#cbd5e1',   /* Slate 300 */
                            accent: '#2563eb', /* Blue 600 */
                            hover: '#334155'   /* Slate 700 */
                        }
                    }
                }
            }
        }
    </script>
    
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <asset:stylesheet src="application.css"/>
    <g:layoutHead/>
</head>
<body class="bg-brand-dark text-brand-text font-sans min-h-screen flex overflow-x-hidden">

    <button onclick="toggleSidebar()" class="fixed top-4 right-4 z-50 bg-brand-accent text-white p-2 rounded-lg shadow-lg md:hidden hover:bg-blue-700 transition">
        <i class="fas fa-bars text-xl"></i>
    </button>

    <div id="mobileOverlay" onclick="toggleSidebar()" class="fixed inset-0 bg-black/50 z-40 hidden backdrop-blur-sm transition-opacity"></div>

    <aside id="sidebar" class="fixed top-0 left-0 h-full w-64 bg-brand-panel border-r border-slate-700 flex flex-col z-50 transform -translate-x-full md:translate-x-0 transition-transform duration-300 shadow-xl">
        
        <div class="p-6 text-center border-b border-slate-700">
            <div class="relative inline-block group">
                
            </div>
            <h1 class="mt-4 text-lg font-bold text-white tracking-wide">Proyecto Escolar</h1>
            <p class="text-xs text-slate-500 uppercase tracking-wider mt-1">Desarrollo Web</p>
        </div>

        <nav class="flex-1 overflow-y-auto py-6 px-3 space-y-1">
            
            <a href="${createLink(controller: 'main', action: 'index')}" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg transition-colors hover:bg-brand-hover hover:text-white group">
                <i class="fas fa-home w-6 text-center text-slate-400 group-hover:text-brand-accent transition-colors"></i>
                <span class="ml-3">Inicio</span>
            </a>

            <a href="${createLink(controller: 'main', action: 'lista')}" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg transition-colors hover:bg-brand-hover hover:text-white group">
                <i class="fas fa-database w-6 text-center text-slate-400 group-hover:text-brand-accent transition-colors"></i>
                <span class="ml-3">Registros existentes</span>
            </a>

            <a href="${createLink(controller: 'imagen', action: 'index')}" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg transition-colors hover:bg-brand-hover hover:text-white group">
                <i class="fas fa-images w-6 text-center text-slate-400 group-hover:text-brand-accent transition-colors"></i>
                <span class="ml-3">Galería Multimedia</span>
            </a>

            <a href="${createLink(controller: 'form', action: 'index')}" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg transition-colors hover:bg-brand-hover hover:text-white group">
                <i class="fas fa-file-contract w-6 text-center text-slate-400 group-hover:text-brand-accent transition-colors"></i>
                <span class="ml-3">Formulario de prueba</span>
            </a>

            <a href="${createLink(controller: 'main', action: 'probarError')}" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg transition-colors hover:bg-brand-hover hover:text-white group">
                <i class="fas fa-file-contract w-6 text-center text-slate-400 group-hover:text-brand-accent transition-colors"></i>
                <span class="ml-3">Pantalla de error 500</span>
            </a>    

            <a href="${createLink(controller: 'main', action: 'Probar404')}" class="flex items-center px-4 py-3 text-sm font-medium rounded-lg transition-colors hover:bg-brand-hover hover:text-white group">
                <i class="fas fa-file-contract w-6 text-center text-slate-400 group-hover:text-brand-accent transition-colors"></i>
                <span class="ml-3">Pantalla de error 404</span>
            </a>

        </nav>

        <div class="p-4 border-t border-slate-700 bg-slate-900/30">
            <div class="text-center mb-3">
                <p class="text-xs font-bold text-white">RODRIGO SANCHEZ CRUZ</p>
                <p class="text-[10px] text-slate-500">8 IDGS-G1</p>
            </div>
            
            <div class="flex justify-center space-x-4">
                <a href="https://www.facebook.com/share/1EgwA2pLyF/" target="_blank" class="text-slate-400 hover:text-blue-500 transition-colors transform hover:-translate-y-1">
                    <i class="fab fa-facebook-f text-lg"></i>
                </a>
                <a href="https://www.instagram.com/el_rorro334?igsh=MXBmd3gya3FyMDU1bQ==" target="_blank" class="text-slate-400 hover:text-pink-500 transition-colors transform hover:-translate-y-1">
                    <i class="fab fa-instagram text-lg"></i>
                </a>
                <a href="https://www.linkedin.com/in/rodrigo-sanchez-cruz-925785327" target="_blank" class="text-slate-400 hover:text-blue-400 transition-colors transform hover:-translate-y-1">
                    <i class="fab fa-linkedin-in text-lg"></i>
                </a>
                <a href="https://github.com/Elrorro334" target="_blank" class="text-slate-400 hover:text-white transition-colors transform hover:-translate-y-1">
                    <i class="fab fa-github text-lg"></i>
                </a>
            </div>
        </div>
    </aside>

    <div class="flex-1 flex flex-col md:ml-64 transition-all duration-300">
        
        <main class="flex-1 p-6 md:p-10 w-full max-w-6xl mx-auto">
            <g:layoutBody/>
        </main>

        <footer class="py-6 text-center text-xs text-slate-600 border-t border-slate-800 mt-auto">
            &copy; 2026 Proyecto Escolar. Todos los derechos reservados.
        </footer>
    </div>

    <script>
        // Toggle Sidebar Móvil
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('mobileOverlay');
            
            if (sidebar.classList.contains('-translate-x-full')) {
                sidebar.classList.remove('-translate-x-full');
                overlay.classList.remove('hidden');
            } else {
                sidebar.classList.add('-translate-x-full');
                overlay.classList.add('hidden');
            }
        }

        // Marcar Link Activo Automáticamente
        document.addEventListener("DOMContentLoaded", function() {
            const currentPath = window.location.pathname;
            const links = document.querySelectorAll('nav a');
            
            links.forEach(link => {
                // Lógica simple: Si el href está en la URL actual, actívalo
                const href = link.getAttribute('href');
                if (href !== '/' && currentPath.includes(href)) {
                    link.classList.add('bg-brand-accent', 'text-white', 'shadow-lg');
                    link.classList.remove('hover:bg-brand-hover', 'text-slate-400');
                    // Cambiar color del icono
                    const icon = link.querySelector('i');
                    if(icon) icon.classList.remove('text-slate-400', 'group-hover:text-brand-accent');
                    if(icon) icon.classList.add('text-white');
                }
            });
        });
    </script>

    <asset:javascript src="application.js"/>
</body>
</html>