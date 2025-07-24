class TimerReserva {
    constructor(fechaReserva, horaInicio, elementoId) {
        this.fechaReserva = fechaReserva;
        this.horaInicio = horaInicio;
        this.elemento = document.getElementById(elementoId);
        this.intervalo = null;
        this.horaPeruOffset = 0;
        this.horaBaseAPI = null;
        this.timestampBaseAPI = null;
        this.usandoHoraLocal = true; // Empezar con hora local para carga inmediata
        
        this.inicializar();
    }
    
    async inicializar() {
        // Mostrar timer inmediatamente con hora local
        this.iniciarTimerLocal();
        
        // Sincronizar en segundo plano
        try {
            await this.sincronizarHoraPeruana();
            this.actualizarAHoraPeruana();
        } catch (error) {
            console.warn('Usando hora local como fallback:', error);
            // Continuar con hora local si falla la API
        }
    }
    
    iniciarTimerLocal() {
        this.usandoHoraLocal = true;
        this.iniciarTimer();
        console.log('🕐 Timer iniciado con hora local');
    }
    
    async sincronizarHoraPeruana() {
        try {
            const response = await fetch('horaPeru?formato=json', {
                method: 'GET',
                timeout: 3000 // Timeout de 3 segundos
            });
            
            if (!response.ok) throw new Error('API no disponible');
            
            const data = await response.json();
            
            // Calcular offset con la hora peruana
            const horaPeruana = new Date(data.datetime);
            const horaLocal = new Date();
            this.horaPeruOffset = horaPeruana.getTime() - horaLocal.getTime();
            
            // Guardar hora base para cálculos híbridos
            this.horaBaseAPI = horaPeruana;
            this.timestampBaseAPI = Date.now();
            
            console.log('✅ Hora sincronizada con Perú:', data.hora);
            console.log('📊 Offset calculado:', this.horaPeruOffset, 'ms');
            
        } catch (error) {
            throw new Error('No se pudo obtener la hora de Perú: ' + error.message);
        }
    }
    
    actualizarAHoraPeruana() {
        this.usandoHoraLocal = false;
        console.log('🔄 Cambiando a hora peruana sincronizada');
    }
    
    obtenerHoraActual() {
        if (this.usandoHoraLocal || !this.horaBaseAPI) {
            // Usar hora local con offset (si está disponible)
            const ahora = new Date();
            return new Date(ahora.getTime() + this.horaPeruOffset);
        } else {
            // Usar hora híbrida (base API + tiempo transcurrido local)
            const tiempoTranscurrido = Date.now() - this.timestampBaseAPI;
            return new Date(this.horaBaseAPI.getTime() + tiempoTranscurrido);
        }
    }
    
    iniciarTimer() {
        if (this.intervalo) {
            clearInterval(this.intervalo);
        }
        
        const fechaHoraInicio = new Date(`${this.fechaReserva}T${this.horaInicio}`);
        
        this.intervalo = setInterval(() => {
            const ahora = this.obtenerHoraActual();
            const tiempoHastaInicio = fechaHoraInicio.getTime() - ahora.getTime();
            
            if (tiempoHastaInicio <= 0) {
                this.mostrarReservaActiva();
                clearInterval(this.intervalo);
            } else {
                this.mostrarTiempoHastaInicio(tiempoHastaInicio);
            }
        }, 1000);
        
        // Re-sincronizar cada 2 minutos en segundo plano
        setInterval(() => {
            this.resincronizar();
        }, 120000); // 2 minutos
    }
    
    async resincronizar() {
        try {
            await this.sincronizarHoraPeruana();
            console.log('🔄 Re-sincronización exitosa');
        } catch (error) {
            console.warn('⚠️ Re-sincronización falló, continuando con hora local');
        }
    }
    
    mostrarTiempoHastaInicio(milisegundos) {
        const dias = Math.floor(milisegundos / (1000 * 60 * 60 * 24));
        const horas = Math.floor((milisegundos % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        const minutos = Math.floor((milisegundos % (1000 * 60 * 60)) / (1000 * 60));
        const segundos = Math.floor((milisegundos % (1000 * 60)) / 1000);
        
        let mensaje = '';
        let clase = '';
        let icono = '';
        
        if (dias > 0) {
            mensaje = `${dias}d ${horas}h ${minutos}m para comenzar`;
            clase = 'text-info';
            icono = '📅';
        } else if (horas > 0) {
            mensaje = `${horas}h ${minutos}m ${segundos}s para comenzar`;
            clase = horas > 1 ? 'text-info' : 'text-warning';
            icono = '⏰';
        } else if (minutos > 0) {
            mensaje = `${minutos}m ${segundos}s para comenzar`;
            clase = minutos > 15 ? 'text-warning' : 'text-success';
            icono = '⏰';
        } else {
            mensaje = `${segundos}s para comenzar`;
            clase = 'text-success';
            icono = '🚀';
        }
        
        // Indicador visual del estado del timer
        const indicador = this.usandoHoraLocal ? 
            (this.horaPeruOffset !== 0 ? '🌐' : '📱') : '🇵🇪';
        
        this.elemento.innerHTML = `<span class="${clase}"><strong>${icono} ${mensaje}</strong> <small class="text-muted">${indicador}</small></span>`;
    }
    
    mostrarReservaActiva() {
        this.elemento.innerHTML = '<span class="text-success"><strong>✅ Tu reserva está activa ahora</strong></span>';
    }
    
    mostrarError() {
        this.elemento.innerHTML = '<span class="text-muted">⏰ Error en timer - usando hora local</span>';
        // Fallback a hora local
        this.usandoHoraLocal = true;
    }
    
    detener() {
        if (this.intervalo) {
            clearInterval(this.intervalo);
        }
    }
}

function inicializarTimerReserva(fechaReserva, horaInicio, elementoId) {
    return new TimerReserva(fechaReserva, horaInicio, elementoId);
}
