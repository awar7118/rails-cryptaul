// import Swal from 'sweetalert2/dist/sweetalert2.js'
// import 'sweetalert2/src/sweetalert2.scss'



// const initSweetalert = (selector, options = {}, callback = () => {}) => {
//   document.addEventListener("sweet-alert-fire", () => {
//   const swalButton = document.querySelectorAll(selector);
//   console.log(swalButton)
//   if (swalButton) { // protect other pages
//     swalButton.forEach((button) => {
//       button.addEventListener('click', (event) => {
//         console.log(event)
//         Swal.fire(options).then(function () {
//           const links = document.querySelectorAll('.watchlist-delete')
//           links.forEach((link) => {
//             link.click()
//           })
//           // location.reload()
//         }); // <-- add the `.then(callback)`
//       });
//     });
//   }
//   });
// };

export { initSweetalert };
