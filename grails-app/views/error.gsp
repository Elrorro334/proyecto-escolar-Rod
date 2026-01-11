<!DOCTYPE html>
<html>
<head>
    <title>Error Servidor | Rodnix</title>
    <meta name="layout" content="main">
    <style>
        .error-container {
            max-width: 700px; margin: 80px auto; text-align: center;
            background: #1a1c23; padding: 60px 40px; border-radius: 20px;
            border: 1px solid #2c2f3b; color: #ffffff;
        }
        .text-red { color: #ff4757; text-shadow: 0 0 15px rgba(255, 71, 87, 0.3); }
        .big-icon { font-size: 5rem; margin-bottom: 20px; }
        .big-code { font-size: 8rem; font-weight: 800; line-height: 1; }
        .btn-rodnix {
            background: #ff4757; color: #fff; padding: 15px 35px;
            border-radius: 50px; text-decoration: none; font-weight: bold;
            display: inline-block; margin-top: 30px;
        }
        .debug { text-align: left; background: #000; padding: 20px; margin-top: 30px; border-left: 4px solid #ff4757; color: #fab1a0; font-family: monospace; overflow: auto;}
    </style>
</head>
<body>
    <div class="error-container">
        <div class="big-icon text-red"><i class="fas fa-bug"></i></div>
        <div class="big-code text-red">500</div>
        <h1>Error del Servidor</h1>
        <p style="color:#aaa; font-size:1.2em;">Algo tronó internamente.</p>
        
        <a href="${createLink(uri: '/')}" class="btn-rodnix">
            <i class="fas fa-home"></i> Reiniciar
        </a>

        <g:if test="${env == 'development' && exception}">
            <div class="debug">
                <strong>Error:</strong> ${exception.message}<br>
                <g:renderException exception="${exception}" />
            </div>
        </g:if>
    </div>
</body>
</html>