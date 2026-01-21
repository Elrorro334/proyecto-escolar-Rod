<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Formulario Corporativo</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        /* --- ESTILOS BASE --- */
        body { 
            font-family: 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif; 
            background-color: #f0f2f5; 
            color: #333;
        }
        
        .form-container { 
            background: #ffffff; 
            max-width: 700px; 
            margin: 40px auto; 
            padding: 40px; 
            border-radius: 8px; 
            box-shadow: 0 2px 15px rgba(0,0,0,0.08); 
            border-top: 5px solid #2c3e50; /* Acento corporativo superior */
        }

        /* --- TIPOGRAFÍA Y ENCABEZADOS --- */
        h1 { 
            color: #2c3e50; 
            font-size: 1.6rem; 
            margin-bottom: 25px; 
            padding-bottom: 15px; 
            border-bottom: 1px solid #e1e4e8;
            font-weight: 600;
        }
        
        h3 { 
            color: #34495e; 
            font-size: 1.1rem; 
            margin-top: 30px; 
            margin-bottom: 20px; 
            display: flex; 
            align-items: center; 
            gap: 10px;
        }
        
        h3 i { color: #3498db; } /* Iconos de sección en azul */

        /* --- INPUT GROUPS CON ICONOS --- */
        .form-group { margin-bottom: 20px; }
        
        label { 
            display: block; 
            font-weight: 600; 
            margin-bottom: 8px; 
            color: #555; 
            font-size: 0.9rem;
        }
        label.required::after { content: " *"; color: #e74c3c; }

        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        /* Icono dentro del input */
        .input-wrapper i {
            position: absolute;
            left: 12px;
            color: #95a5a6;
            font-size: 0.9rem;
            z-index: 2;
            transition: color 0.3s;
        }

        /* Inputs estilizados */
        input[type=text], input[type=email], input[type=password], input[type=number], input[type=url], select, textarea {
            width: 100%; 
            padding: 10px 10px 10px 35px; /* Padding izquierdo para dejar espacio al icono */
            border: 1px solid #dcdfe6; 
            border-radius: 4px; 
            font-size: 14px;
            color: #2c3e50;
            background-color: #fff;
            transition: all 0.3s ease;
        }

        /* Estados Focus */
        input:focus, select:focus, textarea:focus { 
            outline: none; 
            border-color: #3498db; 
            box-shadow: 0 0 0 3px rgba(52,152,219,0.1); 
        }
        
        /* Cambiar color del icono al hacer focus en el input */
        .input-wrapper:focus-within i { color: #3498db; }

        /* Validación Visual */
        input:required:valid, select:required:valid { border-right: 3px solid #2ecc71; }
        input:required:invalid { border-right: 3px solid #e74c3c; }

        /* --- MENSAJES DE ESTADO --- */
        .alert-box {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            font-size: 0.95rem;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }
        
        .alert-success { background-color: #f0f9eb; color: #67c23a; border: 1px solid #e1f3d8; }
        .alert-error { background-color: #fef0f0; color: #f56c6c; border: 1px solid #fde2e2; }
        .alert-box ul { margin: 0; padding-left: 20px; }

        /* --- BOTÓN --- */
        .btn-submit {
            background-color: #2c3e50; 
            color: white; 
            border: none; 
            padding: 12px 25px; 
            font-size: 15px; 
            border-radius: 4px; 
            cursor: pointer; 
            width: 100%; 
            font-weight: 600; 
            letter-spacing: 0.5px;
            transition: background 0.3s, transform 0.1s;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
        }
        .btn-submit:hover { background-color: #1a252f; }
        .btn-submit:active { transform: translateY(1px); }

        /* --- ELEMENTOS EXTRA --- */
        .radio-group label { margin-right: 20px; font-weight: normal; cursor: pointer; color: #606266; }
        .checkbox-container { 
            background: #f8f9fa; 
            padding: 15px; 
            border-radius: 4px; 
            border: 1px solid #eee;
            margin-top: 30px;
            margin-bottom: 20px;
        }
        .checkbox-label { display: flex; align-items: center; gap: 10px; font-weight: normal; cursor: pointer; margin: 0; }
        input[type=checkbox] { margin: 0; width: 16px; height: 16px; cursor: pointer; }
        
        small { color: #909399; font-size: 0.85rem; margin-top: 4px; display: block; }
    </style>
</head>
<body>

<div class="form-container">
    <h1><i class="fas fa-file-signature"></i> Formulario de Registro</h1>

    <g:if test="${flash.message}">
        <div class="alert-box alert-success">
            <i class="fas fa-check-circle fa-lg" style="margin-top: 3px;"></i>
            <div>
                <strong>Operación exitosa</strong><br>
                ${flash.message}
            </div>
        </div>
    </g:if>

    <g:hasErrors bean="${cmd}">
        <div class="alert-box alert-error">
            <i class="fas fa-exclamation-triangle fa-lg" style="margin-top: 3px;"></i>
            <div>
                <strong>Se encontraron errores en el formulario</strong>
                <ul>
                    <g:eachError bean="${cmd}" var="error">
                        <li><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
            </div>
        </div>
    </g:hasErrors>

    <g:form controller="form" action="simular" autocomplete="off">
        
        <h3><i class="fas fa-user-shield"></i> Información Personal</h3>
        
        <div class="form-group">
            <label for="nombre" class="required">Nombre Completo</label>
            <div class="input-wrapper">
                <i class="fas fa-user"></i>
                <g:textField name="nombre" value="${cmd?.nombre}" required="true" maxlength="50" minlength="3" placeholder="Ingrese nombre y apellidos" />
            </div>
        </div>

        <div class="form-group">
            <label for="email" class="required">Correo Electrónico</label>
            <div class="input-wrapper">
                <i class="fas fa-envelope"></i>
                <g:textField name="email" type="email" value="${cmd?.email}" required="true" maxlength="100" placeholder="usuario@empresa.com"/>
            </div>
        </div>

        <div class="form-group">
            <label for="password" class="required">Contraseña</label>
            <div class="input-wrapper">
                <i class="fas fa-lock"></i>
                <g:passwordField name="password" required="true" minlength="6" maxlength="20" placeholder="Mínimo 6 caracteres"/>
            </div>
        </div>

        <div class="form-group">
            <label for="sitioWeb">Sitio Web / Portfolio</label>
            <div class="input-wrapper">
                <i class="fas fa-globe"></i>
                <g:textField name="sitioWeb" type="url" value="${cmd?.sitioWeb}" placeholder="https://..." maxlength="255"/>
            </div>
            <small>Incluya el protocolo (http:// o https://)</small>
        </div>

        <div class="form-group">
            <label for="biografia">Perfil Profesional</label>
            <div class="input-wrapper">
                <i class="fas fa-align-left" style="top: 15px;"></i> <g:textArea name="biografia" rows="4" maxlength="1000" placeholder="Resumen de experiencia y objetivos...">${cmd?.biografia}</g:textArea>
            </div>
            <small>Máximo 1000 caracteres.</small>
        </div>

        <h3><i class="fas fa-chart-pie"></i> Datos Demográficos</h3>

        <div style="display: flex; gap: 20px;">
            <div class="form-group" style="flex: 1;">
                <label for="edad" class="required">Edad</label>
                <div class="input-wrapper">
                    <i class="fas fa-birthday-cake"></i>
                    <g:field type="number" name="edad" value="${cmd?.edad}" required="true" min="18" max="99" placeholder="Ej. 25"/>
                </div>
            </div>

            <div class="form-group" style="flex: 1;">
                <label for="salario" class="required">Pretensión Salarial</label>
                <div class="input-wrapper">
                    <i class="fas fa-dollar-sign"></i>
                    <g:field type="number" name="salario" value="${cmd?.salario}" required="true" min="0.01" step="0.01" placeholder="0.00"/>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="required">Fecha de Nacimiento</label>
            <div style="border: 1px solid #dcdfe6; padding: 8px; border-radius: 4px; background: #fff;">
                <g:datePicker name="fechaNacimiento" value="${cmd?.fechaNacimiento}" precision="day" years="${1960..2008}"/>
            </div>
        </div>

        <h3><i class="fas fa-clipboard-list"></i> Preferencias y Habilidades</h3>

        <div class="form-group">
            <label class="required">Género</label>
            <div class="radio-group" style="padding: 10px 0;">
                <g:radioGroup name="genero" labels="['Masculino','Femenino','Otro']" values="['Masculino','Femenino','Otro']" value="${cmd?.genero}">
                    <label><i class="fas fa-circle" style="font-size: 8px; vertical-align: middle; margin-right: 5px; color: #ccc;"></i> ${it.radio} ${it.label}</label>
                </g:radioGroup>
            </div>
        </div>

        <div class="form-group">
            <label for="departamento" class="required">Departamento</label>
            <div class="input-wrapper">
                <i class="fas fa-building"></i>
                <g:select name="departamento" from="${['Ventas', 'TI', 'RH', 'Finanzas']}" 
                          value="${cmd?.departamento}" 
                          noSelection="['':'- Seleccione Departamento -']"
                          required="true"/>
            </div>
        </div>

        <div class="form-group">
            <label for="habilidades" class="required">Habilidades Técnicas</label>
            <div class="input-wrapper">
                <i class="fas fa-code" style="top: 15px;"></i>
                <g:select name="habilidades" from="${['Java', 'Groovy', 'Grails', 'SQL', 'Docker', 'Spring Boot']}" 
                          value="${cmd?.habilidades}" 
                          multiple="true" 
                          size="5"
                          required="true"/>
            </div>
            <small>Mantenga presionado Ctrl (o Cmd) para seleccionar múltiples opciones.</small>
        </div>

        <div class="checkbox-container">
            <label class="checkbox-label">
                <g:checkBox name="aceptaTerminos" value="${cmd?.aceptaTerminos}" required="true"/>
                <span>Confirmo que he leído y acepto los <a href="#" style="color:#3498db; text-decoration: none;">términos de servicio</a>. <span style="color:red">*</span></span>
            </label>
        </div>

        <div class="form-group">
            <button type="submit" name="enviar" class="btn-submit">
                <i class="fas fa-paper-plane"></i> Enviar Solicitud
            </button>
        </div>

    </g:form>
</div>

</body>
</html>