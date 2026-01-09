<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Registro | Rodnix</title>
    
    <link rel="icon" href="https://rodnix.com.mx/images/logoRODNIX.jpg" type="image/x-icon" />

    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet"/>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <script src="https://www.google.com/recaptcha/api.js" async defer></script>

    <style>
        :root {
            --bg-dark: #0f1014;
            --input-bg: #1a1c23;
            --text-main: #ffffff;
            --text-secondary: #a0a0a0;
            --accent: #3b82f6; 
            --accent-hover: #2563eb;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--bg-dark);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        /* HEADER */
        .header {
            position: absolute;
            top: 0;
            left: 0;
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

        /* Contenido Central */
        .main-content {
            text-align: center;
            padding: 2rem;
            margin-top: 40px;
            width: 100%;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }

        h1 {
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            margin-bottom: 0.5rem;
            font-weight: 700;
        }

        p { color: var(--text-secondary); font-size: 1.1rem; margin-bottom: 2rem; }

        /* Formulario */
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

        .input-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            color: var(--text-secondary);
        }

        .form-control {
            width: 100%;
            padding: 0.8rem 1rem;
            background-color: var(--bg-dark);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 8px;
            color: white;
            font-family: 'Montserrat', sans-serif;
            outline: none;
            transition: border-color 0.3s ease;
        }

        .form-control:focus { border-color: var(--accent); }

        /* Centrar el Captcha */
        .captcha-wrapper {
            display: flex;
            justify-content: center;
            margin: 0.5rem 0;
        }

        .btn-submit {
            background-color: var(--accent);
            color: white;
            border: none;
            padding: 1rem;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
            width: 100%;
            font-size: 1rem;
        }

        .btn-submit:hover { background-color: var(--accent-hover); }

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
        <h1>Registro</h1>
        <p>Ingresa tus nombre</p>

        <form action="/save" method="POST" class="rodnix-form">
            
            <div class="input-group">
                <label for="nombre">Nombre Completo</label>
                <input type="text" id="nombre" name="nombre" class="form-control" placeholder="Ej. Rodrigo Sánchez" required>
            </div>

            <div class="captcha-wrapper">
                <div class="g-recaptcha" 
                     data-sitekey="6LcxNUMsAAAAAJCF18aZ7IRp8F_FEbDCAr-rgChp" 
                     data-theme="dark">
                </div>
            </div>

            <button type="submit" class="btn-submit">
                <i class="fas fa-database"></i> Guardar en BD
            </button>
        </form>
    </main>

    <footer class="footer">
        <ul class="social-list">
            <li><a href="https://www.facebook.com/share/1EgwA2pLyF/" target="_blank" class="social-link"><i class="fab fa-facebook"></i></a></li>
            <li><a href="https://www.instagram.com/el_rorro334?igsh=MXBmd3gya3FyMDU1bQ==" target="_blank" class="social-link"><i class="fab fa-instagram"></i></a></li>
            <li><a href="https://www.linkedin.com/in/rodrigo-sanchez-cruz-925785327" target="_blank" class="social-link"><i class="fab fa-linkedin-in"></i></a></li>
            <li><a href="https://github.com/Elrorro334" target="_blank" class="social-link"><i class="fab fa-github"></i></a></li>
        </ul>
    </footer>

</body>
</html>