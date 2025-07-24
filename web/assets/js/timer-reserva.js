class TimerReserva {
    constructor(fechaReserva, horaInicio, elementoId) {
        this.fechaReserva = fechaReserva;
        this.horaInicio = horaInicio;
        this.elemento = document.getElementById(elementoId);
        this.intervalo = null;
        this.horaPeruOffset = 0;
        
        this.inicializar();
    }
    
    async inicializar() {
        try {
            await this.sincronizarHoraPeruana();
            this.iniciarTimer();
        } catch (error) {
            console.error('Error al sincronizar hora:', error);
            this.mostrarError();
        }
    }
    
    async sincronizarHoraPeruana() {
        try {
            const response = await fetch('horaPeru?formato=json');
            const data = await response.json();
            
            const horaPeruana = new Date(data.datetime);
            const horaLocal = new Date();
            this.horaPeruOffset = horaPeruana.getTime() - horaLocal.getTime();
            
            console.log('Hora sincronizada con Perú:', data.hora);
        } catch (error) {
            throw new Error('No se pudo obtener la hora de Perú');
        }
    }
    
    obtenerHoraPeruanaActual() {
        const ahora = new Date();
        return new Date(ahora.getTime() + this.horaPeruOffset);
    }
    
    iniciarTimer() {
        const fechaHoraInicio = new Date(`${this.fechaReserva}T${this.horaInicio}`);
        
        this.intervalo = setInterval(() => {
            const ahora = this.obtenerHoraPeruanaActual();
            const tiempoHastaInicio = fechaHoraInicio.getTime() - ahora.getTime();
            
            if (tiempoHastaInicio <= 0) {
                this.mostrarReservaActiva();
                clearInterval(this.intervalo);
            } else {
                this.mostrarTiempoHastaInicio(tiempoHastaInicio);
            }
        }, 1000);
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
        
        this.elemento.innerHTML = `<span class="${clase}"><strong>${icono} ${mensaje}</strong></span>`;
    }
    
    mostrarReservaActiva() {
        this.elemento.innerHTML = '<span class="text-success"><strong>✅ Tu reserva está activa ahora</strong></span>';
    }
    
    mostrarError() {
        this.elemento.innerHTML = '<span class="text-muted">⏰ Error en timer</span>';
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
function inicializarTimerReserva(fechaReserva, horaInicio, elementoId) {
    return new TimerReserva(fechaReserva, horaInicio, elementoId);
}
