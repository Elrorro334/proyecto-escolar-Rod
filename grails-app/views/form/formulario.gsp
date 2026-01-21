<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Simulador de Formulario Grails</title>
    <style>
        .form-group { margin-bottom: 15px; }
        label { display: block; font-weight: bold; }
        .error { color: red; font-size: 0.9em; }
        .errors-box { background: #ffe6e6; border: 1px solid red; padding: 10px; margin-bottom: 20px;}
        input[type=text], input[type=email], input[type=password], select, textarea {
            width: 100%; max-width: 400px; padding: 5px;
        }
    </style>
</head>
<body>

<div style="padding: 20px;">
    <h1>Simulación de Tipos de Datos</h1>

    <g:if test="${flash.message}">
        <div style="background: #11d954; border: 1px solid green; padding: 10px;">
            ${flash.message}
        </div>
    </g:if>

    <g:hasErrors bean="${cmd}">
        <div class="errors-box">
            <h3>Se encontraron errores:</h3>
            <ul>
                <g:eachError bean="${cmd}" var="error">
                    <li><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
        </div>
    </g:hasErrors>

    <g:form controller="form" action="simular">
        
        <h3>Texto y Cadenas</h3>
        <div class="form-group">
            <label>Nombre (Texto simple):</label>
            <g:textField name="nombre" value="${cmd?.nombre}" class="${hasErrors(bean: cmd, field: 'nombre', 'error')}"/>
        </div>

        <div class="form-group">
            <label>Email (Validación formato):</label>
            <g:textField name="email" value="${cmd?.email}"/>
        </div>

        <div class="form-group">
            <label>Contraseña (Oculto):</label>
            <g:passwordField name="password"/>
        </div>

        <div class="form-group">
            <label>Sitio Web (URL):</label>
            <g:textField name="sitioWeb" value="${cmd?.sitioWeb}"/>
        </div>

        <div class="form-group">
            <label>Biografía (Area de texto):</label>
            <g:textArea name="biografia" value="${cmd?.biografia}" rows="3"/>
        </div>

        <hr/>
        <h3>Numéricos</h3>
        <div class="form-group">
            <label>Edad (Entero 18-99):</label>
            <g:field type="number" name="edad" value="${cmd?.edad}"/>
        </div>

        <div class="form-group">
            <label>Salario Esperado (Decimal):</label>
            <g:field type="number" step="0.01" name="salario" value="${cmd?.salario}"/>
        </div>

        <hr/>
        <h3>Fechas</h3>
        <div class="form-group">
            <label>Fecha de Nacimiento:</label>
            <g:datePicker name="fechaNacimiento" value="${cmd?.fechaNacimiento}" precision="day" years="${1950..2025}"/>
        </div>

        <hr/>
        <h3>Selecciones</h3>
        <div class="form-group">
            <label>Género (Radio Buttons):</label>
            <g:radioGroup name="genero" labels="['Masculino','Femenino','Otro']" values="['Masculino','Femenino','Otro']" value="${cmd?.genero}">
                <label style="display:inline; font-weight:normal; margin-right:10px;">${it.radio} ${it.label}</label>
            </g:radioGroup>
        </div>

        <div class="form-group">
            <label>Departamento (Select simple):</label>
            <g:select name="departamento" from="${['Ventas', 'TI', 'RH']}" 
                      value="${cmd?.departamento}" noSelection="['':'-Seleccione-']"/>
        </div>

        <div class="form-group">
            <label>Habilidades (Select Múltiple - Presiona Ctrl):</label>
            <g:select name="habilidades" from="${['Java', 'Groovy', 'Grails', 'SQL', 'HTML']}" 
                      value="${cmd?.habilidades}" multiple="true"/>
        </div>

        <hr/>
        <h3>Lógica</h3>
        <div class="form-group">
            <label>
                <g:checkBox name="aceptaTerminos" value="${cmd?.aceptaTerminos}" />
                Acepto los términos y condiciones (Obligatorio)
            </label>
        </div>

        <div class="form-group">
            <g:submitButton name="enviar" value="Simular Envío" />
        </div>

    </g:form>
</div>

</body>
</html>