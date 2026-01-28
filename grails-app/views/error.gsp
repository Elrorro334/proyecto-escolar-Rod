<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="layout" content="null">
    <title>Error del Servidor | 500</title>
    
    <script src="https://cdn.tailwindcss.com"></script>

    <style>
        body {
            background-color: #020202;
            color: #e5e5e5;
            font-family: ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }
        
        /* Mantiene la proporción cuadrada y evita que sea excesivamente alta */
        .lottie-fluid {
            width: 100%;
            height: auto;
            aspect-ratio: 1 / 1; 
            max-height: 85vh; /* Le di un poquito más de altura máxima (de 80 a 85vh) */
            border: none;
            pointer-events: none;
        }

        .bg-texture {
            background-image: url('https://www.transparenttextures.com/patterns/stardust.png');
            opacity: 0.05;
        }
    </style>
</head>
<body class="min-h-screen w-full flex items-center justify-center relative bg-[radial-gradient(circle_at_center,_var(--tw-gradient-stops))] from-gray-900 via-[#000] to-[#000] p-4 md:p-8 overflow-hidden">

    <div class="absolute inset-0 bg-texture pointer-events-none"></div>

    <div class="z-10 w-full max-w-[90rem] mx-auto flex flex-col md:flex-row items-center justify-center gap-8 md:gap-12">
        
        <div class="w-full md:w-1/2 flex justify-center md:justify-end order-1">
            <iframe src="https://lottie.host/embed/c8bf02f4-48a4-43d2-ae90-84fbf36053ee/TfGfstbCsi.lottie" class="lottie-fluid max-w-lg md:max-w-full"></iframe>
        </div>

        <div class="w-full md:w-1/2 flex flex-col items-center md:items-start text-center md:text-left space-y-6 order-2">
            
            <div class="space-y-3">
                 <h1 class="text-4xl md:text-6xl font-extrabold tracking-tight text-white leading-tight">
                    <span class="text-red-600 block text-2xl md:text-3xl mb-2 font-bold">Error 500</span>
                    Fallo del Sistema
                </h1>
                <p class="text-gray-400 text-lg md:text-xl max-w-lg leading-relaxed">
                    Lo sentimos, nuestros servidores encontraron un problema inesperado. El equipo técnico ya ha sido notificado.
                </p>
            </div>

            <div class="flex flex-col sm:flex-row gap-4 pt-4 w-full sm:w-auto">
                <button onclick="window.location.reload()" class="px-8 py-3 bg-red-700 hover:bg-red-600 text-white font-bold rounded-lg transition-all duration-300 shadow-lg shadow-red-900/30 border border-red-800 w-full sm:w-auto flex justify-center items-center gap-2">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-5 h-5">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0l3.181 3.183a8.25 8.25 0 0013.803-3.7M4.031 9.865a8.25 8.25 0 0113.803-3.7l3.181 3.182m0-4.991v4.99" />
                    </svg>
                    Reintentar
                </button>

                <a href="${createLink(uri: '/')}" class="px-8 py-3 bg-transparent hover:bg-gray-800 text-gray-300 hover:text-white font-medium border border-gray-700 rounded-lg transition-all duration-300 text-center w-full sm:w-auto">
                    Ir al Inicio
                </a>
            </div>
        </div>

    </div>

</body>
</html>