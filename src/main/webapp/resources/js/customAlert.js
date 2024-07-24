
	// 커스텀 알럿 
	
	function showAlert(message, callback) {
	  Swal.fire({
	    html: message,
	    confirmButtonText: '확인',
	    customClass: {
	      confirmButton: 'swal2-confirm',
	      popup: 'custom-swal-popup',
	      htmlContainer: 'custom-swal-text'
	    },
	    scrollbarPadding: false,
	    allowOutsideClick: false,
	    heightAuto: false,
	    didOpen: () => {
	      document.body.style.paddingRight = '0px';
	    }
	  }).then((result) => {
	    if (result.isConfirmed && callback) {
	      callback();
	    }
	  });
	}
	 
	function showConfirm(message, confirmCallback, cancelCallback) {
	  Swal.fire({
	    html: message,
	    showCancelButton: true,
	    cancelButtonText: '아니요',
	    confirmButtonText: '네',
	    customClass: {
	      cancelButton: 'swal2-cancel',
	      confirmButton: 'swal2-confirm',
	      popup: 'custom-swal-popup',
	      htmlContainer: 'custom-swal-text'
	    },
	    scrollbarPadding: false,
	    allowOutsideClick: false,
	    heightAuto: false,
	    didOpen: () => {
	      document.body.style.paddingRight = '0px';
	    }
	  }).then((result) => {
	    if (result.isConfirmed && confirmCallback) {
	      confirmCallback();
	    } else if (result.isDismissed && cancelCallback) {
	      cancelCallback();
	    }
	  });
	}