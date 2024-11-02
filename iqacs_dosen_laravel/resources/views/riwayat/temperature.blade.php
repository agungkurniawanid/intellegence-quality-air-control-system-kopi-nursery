<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.js"></script>
    </script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    @vite('resources/css/app.css')

    <style>
        .bg-brown {
            background-color: #4C4B16;
            /* Kode HEX warna coklat */
        }
    </style>
</head>

<body class="flex flex-col h-screen" style="background-color: #f3f4f6;">
    <div class="flex h-screen">
        <aside class="text-white w-52 flex-shrink-0 hidden lg:block "
            style="background-image: url('{{ asset('assets/sidebar-bg.png') }}');">
            <div class="flex items-center justify-between pt-8 pb-4">
                <a class="flex items-center justify-center w-full" href="#">
                    <div class="flex-1 flex justify-center items-center">
                        <div>
                            <img src="{{ asset('images/logo-kopi.png') }}"
                                class="inline h-10 w-10 transition-all duration-200 ease-nav-brand" alt="main_logo" />
                        </div>
                        <div class="ml-2">
                            <span
                                class="block font-semibold text-lwhite transition-all text-body duration-200 mr-4">KOPI</span>
                            <span
                                class="block font-semibold text-lwhite transition-all text-body duration-200 mr-4">NURSERY</span>
                        </div>
                    </div>
                </a>
            </div>
            <nav class="px-2 py-2">
                <ul class="space-y-2 font-medium">
                    <li>
                        <a href="{{ route('dashboard') }}"
                            class="flex items-center block py-2 text-white text-body hover:text-green-600 hover:bg-gray-100 rounded-lg px-3 mb-3 transition duration-200">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" viewBox="0 0 20 20"
                                fill="currentColor">
                                <path
                                    d="M4 11a1 1 0 1 1 2 0v1a1 1 0 1 1-2 0zm6-4a1 1 0 1 1 2 0v5a1 1 0 1 1-2 0zM7 9a1 1 0 0 1 2 0v3a1 1 0 1 1-2 0z" />
                                <path
                                    d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1h1a1 1 0 0 1 1 1V14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V3.5a1 1 0 0 1 1-1h1z" />
                                <path
                                    d="M9.5 1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5zm-3-1A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0z" />
                            </svg>
                            Monitoring
                        </a>
                    </li>
                    <li>
                        <a type="button"
                            class="flex items-center block py-2 text-white text-body hover:text-green-600 hover:bg-gray-100 rounded-lg px-3 mb-3 transition duration-200"
                            aria-controls="dropdown-example" data-collapse-toggle="dropdown-example">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" viewBox="0 0 20 20"
                                fill="currentColor">
                                <path
                                    d="M12 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2M5 4h6a.5.5 0 0 1 0 1H5a.5.5 0 0 1 0-1m-.5 2.5A.5.5 0 0 1 5 6h6a.5.5 0 0 1 0 1H5a.5.5 0 0 1-.5-.5M5 8h6a.5.5 0 0 1 0 1H5a.5.5 0 0 1 0-1m0 2h3a.5.5 0 0 1 0 1H5a.5.5 0 0 1 0-1" />
                            </svg>
                            Rekam Data<svg class="w-2.5 h-2.5 ms-3" aria-hidden="true"
                                xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 10 6">
                                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                    stroke-width="2" d="m1 1 4 4 4-4" />
                            </svg>
                        </a>
                        <ul id="dropdown-example" class="hidden">
                            <li>
                                <a href="{{ route('riwayat.temperature') }}"
                                    class="flex items-center block mx-2 py-1 text-white text-body hover:text-green-600 hover:bg-gray-100 rounded-lg px-3 mb-3 transition duration-200">
                                    Temperature
                                </a>
                            </li>
                            <li>
                                <a href="{{ route('riwayat.humidity') }}"
                                    class="flex items-center block mx-2 py-1 text-white text-body hover:text-green-600 hover:bg-gray-100 rounded-lg px-3 mb-3 transition duration-200">
                                    Humidity
                                </a>
                            </li>
                            <!-- <li>
                                <a hre
                                    class="flex items-center block mx-2 py-1 text-white text-body hover:text-green-600 hover:bg-gray-100 rounded-lg px-3 mb-3 transition duration-200">
                                    Amonia
                                </a>
                            </li>
                            <li>

                                    class="flex items-center block mx-2 py-1 text-white text-body hover:text-green-600 hover:bg-gray-100 rounded-lg px-3 mb-3 transition duration-200">
                                    Karbon Dioksida
                                </a>
                            </li> -->
                        </ul>
                    </li>
                    @if (Auth::user()->role == 'admin')
                        <li>
                            <a href="{{ route('karyawan') }}"
                                class="flex items-center block py-2 text-white text-body hover:text-green-600 hover:bg-gray-100 rounded-lg px-3 mb-3 transition duration-200">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" viewBox="0 0 20 20"
                                    fill="currentColor">
                                    <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0" />
                                    <path
                                        d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm12 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1v-1c0-1-1-4-6-4s-6 3-6 4v1a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1z" />
                                </svg>
                                Data Karyawan
                            </a>
                        </li>
                    @else
                    @endif
                    <li>
                        <a href="{{ route('blog') }}"
                            class="flex items-center block py-2 text-white text-body hover:text-green-600 hover:bg-gray-100 rounded-lg px-3 mb-3 transition duration-200">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" viewBox="0 0 20 20"
                                fill="currentColor">
                                <path
                                    d="M5 10.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5m0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5m0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5m0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5" />
                                <path
                                    d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2" />
                                <path
                                    d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1z" />
                            </svg>
                            Blog
                        </a>
                    </li>
                </ul>
            </nav>
        </aside>
        <div class="flex-1 flex flex-col overflow-hidden">
            <header class="bg-white border-b border-gray-200 p-4 shadow-lg">
                <div class="flex justify-between items-center">
                    <div class="flex items-center">
                        <div class="text-lg font-semibold text-gray-800 mr-2"></div>
                    </div>
                    <div class="flex-grow border-l border-gray-200 mx-4"></div>
                    <div class="relative flex items-center">
                        <div class="border-l border-gray-300 h-6 mr-6"></div>
                        <div>
                            <span class="block text-xs text-gray-600">{{ Auth::user()->name }}</span>
                        </div>
                        <button onclick="toggleDropdown(event)" class="flex items-center focus:outline-none ml-2">
                            <img src="https://via.placeholder.com/40" alt="Profile" class="w-8 h-8 rounded-full">
                        </button>
                        <div id="profileDropdown"
                            class="origin-top-right absolute right-0 mt-44 w-48 bg-white border border-gray-200 rounded-md shadow-lg py-1 hidden">
                            <a href="{{ route('profile') }}"
                                class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Profile</a>
                            <a href="#"
                                class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Settings</a>
                            @livewire('components.logout-button')
                        </div>
                    </div>
                </div>
            </header>
            <main class="flex-1 overflow-y-auto p-4">
                <div class="bg-white shadow-lg rounded-lg mb-4">
                    <div class="flex justify-between items-center px-4 py-3 border-b border-gray-200 bg-gray-50">
                        <h6 class="m-0 font-semibold text-gray-700">Riwayat Temperature</h6>
                        <a href="#" id="export-btn"
                            class="py-1 px-3 bg-brown text-body font-semibold text-lwhite rounded-md flex items-center space-x-2">
                            <svg class="w-4 h-4 text-white dark:text-white" aria-hidden="true"
                                xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 16 18">
                                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                    stroke-width="2"
                                    d="M8 1v11m0 0 4-4m-4 4L4 8m11 4v3a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-3" />
                            </svg>
                            <span>Export</span>
                        </a>
                    </div>
                    <div class="px-4 pb-4">
                        <div class="overflow-x-auto mt-4">
                            <div class="flex items-end justify-end">
                                <div id="daterange"
                                    class="py-2 px-3 bg-brown text-body font-semibold text-lwhite rounded-md flex items-center space-x-2">
                                    <svg class="w-4 h-4 text-white dark:text-white" aria-hidden="true"
                                        xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 20">
                                        <path
                                            d="M0 18a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V8H0v10Zm14-7.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1Zm0 4a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1Zm-5-4a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1Zm0 4a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1Zm-5-4a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1Zm0 4a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1ZM20 4a2 2 0 0 0-2-2h-2V1a1 1 0 0 0-2 0v1h-3V1a1 1 0 0 0-2 0v1H6V1a1 1 0 0 0-2 0v1H2a2 2 0 0 0-2 2v2h20V4Z" />
                                    </svg>
                                    <span></span>
                                </div>
                            </div>
                            <div>
                                <canvas id="myChart"></canvas>
                            </div>
                        </div>
                    </div>

                </div>
            </main>
            <footer class="bg-white border-t border-gray-200 p-4 shadow-md mt-auto">
                <div class="flex items-center justify-center">
                    <p class="text-sm text-gray-500">&copy; Greenhouser Kopi Nursery</p>
                </div>
            </footer>
            <form id="logout-form" action="#" method="POST" style="display: none;">
                @csrf
                <input type="hidden" name="logout" value="true">
            </form>
        </div>
    </div>
    @vite('resources/js/app.js')
    <script type="text/javascript">
        $(document).ready(function() {
            $('#export-btn').click(function() {
                var start = $('#daterange').data('daterangepicker').startDate.format('YYYY-MM-DD');
                var end = $('#daterange').data('daterangepicker').endDate.format('YYYY-MM-DD');

                window.location.href = '{{ route('export.temperature') }}?createFrom=' + start + '&createTo=' +
                    end;
            });
        });
    </script>
    <script type="text/javascript">
        $(function() {
            var start_date = moment().subtract(6, 'days');
            var end_date = moment();

            // Variabel untuk menyimpan referensi chart
            var myChart = null;

            $('#daterange span').html(start_date.format('MMMM D, YYYY') + ' - ' + end_date.format('MMMM D, YYYY'));

            // Fungsi untuk memperbarui chart
            function updateChart(labels, data) {
                var ctx = document.getElementById('myChart').getContext('2d');

                // Hancurkan chart lama jika ada
                if (myChart !== null) {
                    myChart.destroy();
                }

                // Buat chart baru
                myChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Temperature Levels',
                            data: data,
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            }

            // Fungsi untuk mendapatkan data berdasarkan rentang tanggal
            function fetchData(start, end) {
                $.ajax({
                    url: '{{ route('data.riwayattemperature') }}',
                    method: 'POST',
                    data: {
                        createFrom: start.format('YYYY-MM-DD'),
                        createTo: end.format('YYYY-MM-DD'),
                        _token: '{{ csrf_token() }}'
                    },
                    success: function(response) {
                        updateChart(response.labels, response.data);
                    },
                    error: function(xhr, status, error) {
                        console.error(error);
                    }
                });
            }

            // Panggil fetchData saat halaman pertama kali dimuat
            fetchData(start_date, end_date);

            $('#daterange').daterangepicker({
                startDate: start_date,
                endDate: end_date,
                locale: {
                    format: 'MMMM D, YYYY'
                }
            }, function(start, end) {
                $('#daterange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format(
                    'MMMM D, YYYY'));
                fetchData(start, end);
            });
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        var dropdown = document.getElementById('profileDropdown');

        function toggleDropdown(event) {
            event.stopPropagation();
            dropdown.classList.toggle('hidden');
        }
        document.body.addEventListener('click', function(event) {
            if (!event.target.closest('#profileDropdown') && !event.target.closest(
                    'button[onclick="toggleDropdown(event)"]')) {
                dropdown.classList.add('hidden');
            }
        });
    </script>
</body>

</html>
