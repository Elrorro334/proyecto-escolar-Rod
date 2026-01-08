<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Bienvenido | Rodnix</title>
    
    <link rel="icon" href="https://rodnix.com.mx/images/logoRODNIX.jpg" type="image/x-icon" />

    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet"/>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <style>
        :root {
            --bg-dark: #0f1014;
            --text-main: #ffffff;
            --text-secondary: #a0a0a0;
            --accent: #3b82f6; 
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--bg-dark);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        /* HEADER con LOGO */
        .header {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            padding: 1.5rem;
            text-align: center;
        }

        /* Estilo para el logo */
        .logo-img {
            height: 80px; /* Tamaño controlado */
            width: auto;
            display: block;
            margin: 0 auto;
            border-radius: 50%; /* Opcional: si quieres que se vea redondo como en redes */
            transition: transform 0.3s ease;
        }

        .logo-img:hover {
            transform: scale(1.05);
        }

        /* Contenido Central */
        .main-content {
            text-align: center;
            padding: 2rem;
            margin-top: 60px;
        }

        h1 {
            font-family: 'Playfair Display', serif;
            font-size: 3.5rem;
            margin-bottom: 1rem;
            font-weight: 700;
        }

        p {
            color: var(--text-secondary);
            font-size: 1.2rem;
            font-weight: 400;
        }

        /* Footer */
        .footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            padding: 2rem;
            text-align: center;
        }

        .social-list {
            list-style: none;
            display: flex;
            justify-content: center;
            gap: 2rem;
            padding: 0;
        }

        .social-link {
            color: var(--text-secondary);
            font-size: 1.5rem;
            transition: color 0.3s ease;
            text-decoration: none;
        }

        .social-link:hover { color: var(--accent); }
    </style>
</head>
<body>

    <header class="header">
        <a href="https://rodnix.com.mx">
            <img src="https://rodnix.com.mx/images/logoRODNIX.jpg" alt="Rodnix Logo" class="logo-img">
        </a>
    </header>

    <main class="main-content">
        <h1>Hola Mundo</h1>
    </main>

    <footer class="footer">
      RODRIGO SANCHEZ CRUZ 8IDGSM-G1 2026
        <ul class="social-list">
            <li><a href="https://www.facebook.com/share/1EgwA2pLyF/" target="_blank" class="social-link"><i class="fab fa-facebook"></i></a></li>
            <li><a href="https://www.instagram.com/el_rorro334?igsh=MXBmd3gya3FyMDU1bQ==" target="_blank" class="social-link"><i class="fab fa-instagram"></i></a></li>
            <li><a href="https://www.linkedin.com/in/rodrigo-sanchez-cruz-925785327" target="_blank" class="social-link"><i class="fab fa-linkedin-in"></i></a></li>
            <li><a href="https://github.com/Elrorro334" target="_blank" class="social-link"><i class="fab fa-github"></i></a></li>
        </ul>
    </footer>

</body>
</html>