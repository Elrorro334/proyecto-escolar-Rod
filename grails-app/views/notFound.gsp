<!DOCTYPE html>
<html>
<head>
    <title>No Encontrado | Rodnix</title>
    <meta name="layout" content="main">
    <style>
        .error-container {
            max-width: 700px; margin: 80px auto; text-align: center;
            background: #1a1c23; padding: 60px 40px; border-radius: 20px;
            border: 1px solid #2c2f3b; color: #ffffff;
        }
        .text-orange { color: #ffa502; text-shadow: 0 0 15px rgba(255, 165, 2, 0.3); }
        .big-icon { font-size: 5rem; margin-bottom: 20px; }
        .big-code { font-size: 8rem; font-weight: 800; line-height: 1; }
        .btn-rodnix {
            background: #ffa502; color: #000; padding: 15px 35px;
            border-radius: 50px; text-decoration: none; font-weight: bold;
            display: inline-block; margin-top: 30px;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="big-icon text-orange"><i class="fas fa-map-marked-alt"></i></div>
        <div class="big-code text-orange">404</div>
        <h1>Página No Encontrada</h1>
        <p style="color:#aaa; font-size:1.2em;">Enlace roto, ruta no existente.</p>
        
        <a href="${createLink(uri: '/')}" class="btn-rodnix">
            <i class="fas fa-undo"></i> Regresar
        </a>
    </div>
</body>
</html>