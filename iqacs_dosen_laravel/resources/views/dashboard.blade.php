<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Include Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    @vite('resources/css/app.css')

    <style>
        .progress-container {
            position: relative;
            width: 100%;
            height: 20px;
            background: linear-gradient(to right, red, yellow, green);
            border-radius: 10px;
            margin-bottom: 10px;
        }

        .progress-bar-fill {
            height: 100%;
            width: 0;
            background-color: rgba(255, 255, 255, 0.3);
            border-radius: 10px;
        }

        .progress-needle {
            position: absolute;
            top: -10px;
            width: 2px;
            height: 40px;
            background: black;
            transition: left 0.5s;
        }

        .bg-brown {
            background-color: #4C4B16;
            /* Kode HEX warna coklat */
        }
    </style>

</head>

<body class="flex flex-col h-screen">
    <div class="flex h-screen">
        @livewire('partials.sidebar')
        <!-- Content -->
        <div class="flex-1 flex flex-col overflow-hidden">
            <!-- Header -->
            @livewire('partials.header')

            <!-- Main Content -->
            <main class="flex-1 overflow-y-auto p-4">
                <div class="gap-4">
                    <div class="bg-white shadow-lg rounded-lg mb-4">
                        <div class="flex justify-between items-center px-4 py-3 border-b border-gray-200 bg-gray-50">
                            <h6 class="m-0 font-semibold text-gray-700">Dashboard</h6>
                        </div>
                        <div class="px-8 py-8">
                            <div class="grid grid-cols-2 gap-4">
                                @php
                                    $no=1
                                @endphp
                                @foreach ($alatData as $item)
                                    <a href="{{ route('detail.dashboard', ['id' => $item['id_alat']]) }}"
                                        class="col-span-1">



                                        <div
                                            class="bg-brown h-full px-8 rounded-lg shadow-lg flex flex-col justify-center items-center">
                                            <div class="w-full mb-6 items-center mt-4">
                                                <p class="text-white text-lg font-bold">Lokasi Alat : {{ $item['id_alat'] }}</p>
                                                <p class="text-white text-sm font-bold">Keterangan Lokasi:</p>
                                            </div>
                                            <div class="w-full mb-6">
                                                <div class="flex justify-between">
                                                    <div class="flex w-full">
                                                        <p class="text-white text-md font-bold w-1/3">Suhu</p>
                                                        <p class="text-white text-md font-bold w-1/6">:</p>
                                                        <p class="text-white text-md font-bold w-1/2">
                                                            Temperature: {{ $item['Temperature']->nilai_temperature ?? 'Data not available' }}°C
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="w-full mb-6">
                                                <div class="flex justify-between">
                                                    <div class="flex w-full">
                                                        <p class="text-white text-md font-bold w-1/3">Kelembapan</p>
                                                        <p class="text-white text-md font-bold w-1/6">:</p>
                                                        <p class="text-white text-md font-bold w-1/2">
                                                            Humidity: {{ $item['Humidity']->nilai_humidity ?? 'Data not available' }}%
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                            {{-- <div class="w-full mb-6">
                                            <div class="flex justify-between">
                                                <div class="flex w-full">
                                                    <p class="text-white text-md font-bold w-1/3">Ammonia</p>
                                                    <p class="text-white text-md font-bold w-1/6">:</p>
                                                    <p class="text-white text-md font-bold w-1/2">
                                                        @if ($Amonia1->isNotEmpty())
                                                            @foreach ($Amonia1 as $amonia)
                                                                {{ $amonia->nilai_amonia }}
                                        @endforeach
                                        @else
                                        <p class="text-red-500">No Ammonia data available.</p>
                                        @endif
                                        </p>
                                    </div>
                            </div>
                        </div> --}}
                                            {{-- <div class="w-full mb-6">
                                            <div class="flex justify-between">
                                                <div class="flex w-full">
                                                    <p class="text-white text-md font-bold w-1/3">Karbon Dioksida</p>
                                                    <p class="text-white text-md font-bold w-1/6">:</p>
                                                    <p class="text-white text-md font-bold w-1/2">
                                                        @if ($Dioksida1->isNotEmpty())
                                                            @foreach ($Dioksida1 as $dioksida)
                                                                {{ $dioksida->nilai_dioksida }}
                        @endforeach
                        @else
                        <p class="text-red-500">No Dioksida data available.</p>
                        @endif
                        </p>
                    </div>
                </div>
        </div> --}}

                                        </div>
                                    </a>
                                @endforeach
                                {{--  --}}
                            </div>
                        </div>
                    </div>
                </div>
            </main>

            <!-- Footer -->
            @livewire('partials.footer')

            <!-- Logout form (hidden by default) -->
            <form id="logout-form" action="#" method="POST" style="display: none;">
                @csrf
                <input type="hidden" name="logout" value="true">
            </form>
        </div>
    </div>
    @vite('resources/js/app.js')
</body>

</html>
