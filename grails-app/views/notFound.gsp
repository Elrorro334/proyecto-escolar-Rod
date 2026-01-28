<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="layout" content="null">
    <title>No Encontrado | 404</title>
    
    <script src="https://cdn.tailwindcss.com"></script>

    <style>
        body {
            background-color: #ffffff;
            color: #1a1a1a; 
            font-family: ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }
        /* Ajuste para que la animación sea responsive pero respete el max-width */
        .lottie-container iframe {
            border: none;
            width: 100%;
            max-width: 500px; /* Reduje un poco de 600px para dar espacio al texto */
            height: 500px;
            pointer-events: none;
        }
    </style>
</head>
<body class="min-h-screen w-full flex flex-col items-center justify-center bg-white p-4">

    <div class="lottie-container w-full flex justify-center -mb-10">
        <iframe src="https://lottie.host/embed/9f174e3a-4b9c-4df2-9f3c-ff723788144f/7Wh8FnPWR5.lottie"></iframe>
    </div>

    <div class="text-center z-10 max-w-lg mx-auto space-y-6">
        
        <div class="space-y-2">
            <h1 class="text-3xl md:text-4xl font-bold tracking-tight text-gray-900">
                ¡Ups! Página no encontrada
            </h1>
            <p class="text-gray-500 text-lg">
                Parece que el enlace está roto o la página ha sido movida. No te preocupes, esto le pasa hasta a los mejores.
            </p>
        </div>

        <div class="flex flex-col sm:flex-row gap-4 justify-center items-center pt-4">
            <a href="${createLink(uri: '/')}" class="px-8 py-3 bg-black text-white font-medium rounded-lg hover:bg-gray-800 transition-all duration-200 shadow-lg hover:shadow-xl w-full sm:w-auto">
                Volver al Inicio
            </a>

            <button onclick="history.back()" class="px-8 py-3 bg-white text-gray-700 font-medium border border-gray-300 rounded-lg hover:bg-gray-50 transition-all duration-200 w-full sm:w-auto">
                Regresar
            </button>
        </div>
    </div>

</body>
</html>