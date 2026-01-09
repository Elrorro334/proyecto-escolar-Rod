<!doctype html>
<html lang="es" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title><g:layoutTitle default="Rodnix"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    
    <link rel="icon" href="https://rodnix.com.mx/images/logoRODNIX.jpg" type="image/x-icon" />

    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <asset:stylesheet src="application.css"/>
    <g:layoutHead/>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<asset:stylesheet src="application.css"/>
<g:layoutHead/>

    <style>
        :root {
            --bg-dark: #0f1014;
            --input-bg: #1a1c23;
            --text-main: #ffffff;
            --text-secondary: #a0a0a0;
            --accent: #3b82f6; 
            --accent-hover: #2563eb;
            --error: #ef4444;
            --success: #22c55e;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--bg-dark);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            flex-direction: column; /* Importante para el footer pegajoso */
        }

        /* HEADER */
        .header {
            width: 100%;
            padding: 1.5rem;
            text-align: center;
        }
        .logo-img {
            height: 80px;
            width: auto;
            display: block;
            margin: 0 auto;
            transition: transform 0.3s ease;
        }
        .logo-img:hover { transform: scale(1.05); }

        /* CONTENIDO */
        .main-content {
            flex: 1; /* Esto empuja el footer hacia abajo si hay poco contenido */
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
            padding: 2rem 1rem;
            text-align: center;
        }

        h1 {
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            margin-bottom: 0.5rem;
            font-weight: 700;
        }
        p { color: var(--text-secondary); font-size: 1.1rem; margin-bottom: 2rem; }

        /* ALERTAS */
        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            font-weight: 600;
        }
        .alert-success { background-color: rgba(34, 197, 94, 0.2); color: var(--success); border: 1px solid var(--success); }
        .alert-error { background-color: rgba(239, 68, 68, 0.2); color: var(--error); border: 1px solid var(--error); }

        /* FORMULARIO */
        .rodnix-form {
            background-color: var(--input-bg);
            padding: 2rem;
            border-radius: 15px;
            border: 1px solid rgba(255,255,255,0.05);
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }
        .input-group { text-align: left; }
        .input-group label { display: block; margin-bottom: 0.5rem; color: var(--text-secondary); font-size: 0.9rem; }
        
        .form-control {
            width: 100%;
            padding: 0.8rem 1rem;
            background-color: var(--bg-dark);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 8px;
            color: white;
            font-family: 'Montserrat', sans-serif;
            outline: none;
        }
        .form-control:focus { border-color: var(--accent); }

        .captcha-wrapper { display: flex; justify-content: center; margin: 0.5rem 0; }

        .btn-submit {
            background-color: var(--accent);
            color: white;
            border: none;
            padding: 1rem;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            font-size: 1rem;
            transition: background 0.3s ease;
        }
        .btn-submit:hover { background-color: var(--accent-hover); }

        /* TABLA DE RESULTADOS (El recuadro que pediste) */
        .list-container { margin-top: 3rem; text-align: left; }
        .list-container h2 { font-size: 1.5rem; margin-bottom: 1rem; text-align: center; color: var(--text-main); font-family: 'Playfair Display', serif; }

        .rodnix-table {
            width: 100%;
            border-collapse: collapse;
            background-color: var(--input-bg);
            border-radius: 10px;
            overflow: hidden;
            border: 1px solid rgba(255,255,255,0.05);
        }
        .rodnix-table th, .rodnix-table td { padding: 1rem; text-align: left; border-bottom: 1px solid rgba(255,255,255,0.05); }
        .rodnix-table th { background-color: rgba(59, 130, 246, 0.1); color: var(--accent); font-weight: 600; text-transform: uppercase; font-size: 0.8rem; }
        .rodnix-table td { color: var(--text-secondary); font-size: 0.95rem; }
        .rodnix-table tr:last-child td { border-bottom: none; }
        .no-data { text-align: center; color: var(--text-secondary); font-style: italic; background: var(--input-bg); padding: 1rem; border-radius: 10px; }

        /* FOOTER (Arreglado) */
        .footer {
            width: 100%;
            padding: 2rem;
            text-align: center;
            background-color: var(--bg-dark); /* Fondo sólido por si acaso */
            margin-top: auto; /* Mantiene el footer abajo pero flexible */
            position: relative; /* Clave para que no se encime */
        }
        .social-list { list-style: none; display: flex; justify-content: center; gap: 2rem; padding: 0; }
        .social-link { color: var(--text-secondary); font-size: 1.5rem; transition: color 0.3s ease; text-decoration: none; }
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
        <g:layoutBody/>
    </main>

    <footer class="footer">
        <h3>RODRIGO SANCHEZ CRUZ 8 IDGS-G1</h3> 
        <br>
        <ul class="social-list">
            <li><a href="https://www.facebook.com/share/1EgwA2pLyF/" target="_blank" class="social-link"><i class="fab fa-facebook"></i></a></li>
            <li><a href="https://www.instagram.com/el_rorro334?igsh=MXBmd3gya3FyMDU1bQ==" target="_blank" class="social-link"><i class="fab fa-instagram"></i></a></li>
            <li><a href="https://www.linkedin.com/in/rodrigo-sanchez-cruz-925785327" target="_blank" class="social-link"><i class="fab fa-linkedin-in"></i></a></li>
            <li><a href="https://github.com/Elrorro334" target="_blank" class="social-link"><i class="fab fa-github"></i></a></li>
        </ul>
    </footer>

    <asset:javascript src="application.js"/>
</body>
</html>