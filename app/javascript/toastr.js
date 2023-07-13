import toastr from 'toastr';

toastr.options = {
  "closeButton": true,
  "progressBar": false,
  "newestOnTop": true,
  "positionClass": "toast-top-right",
  "showDuration": "300",
  "hideDuration": "1000",
  "timeOut": "1000",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
  "showMethod": "fadeIn",
  "hideMethod": "fadeOut"
};

window.toastr = toastr;