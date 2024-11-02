<?php

use App\Exports\AmmoniaExport;
use App\Exports\DioksidaExport;
use App\Exports\HumidityExport;
use App\Exports\MetanaExport;
use App\Exports\TemperatureExport;
use App\Http\Controllers\ChartsController;
use App\Http\Controllers\RiwayatController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Maatwebsite\Excel\Facades\Excel;

Route::get('/', function () {
    return redirect()->route('login');
});



Route::middleware(['auth', 'verified'])->group(function () {
    Route::get('dashboard', [ChartsController::class, 'index'])->name('dashboard');
    Route::controller(RiwayatController::class)->prefix('/dashboard')->group(function () {
        Route::get('detail/{id}', 'detailDashboard')->name('detail.dashboard');
        // Route::view('detail/2', 'dashboard/detaildashboard2')->name('detail.dashboard2');
        // Route::view('detail/3', 'dashboard/detaildashboard3')->name('detail.dashboard3');
        // Route::view('detail/4', 'dashboard/detaildashboard4')->name('detail.dashboard4');
    });
    Route::get('chartdioksida/{id}', [ChartsController::class, 'dioksida'])->name('api.chartdioksida');
    Route::get('chartamonia/{id}', [ChartsController::class, 'amonia'])->name('api.chartamonia');
    Route::get('chartmetana/{id}', [ChartsController::class, 'metana'])->name('api.chartmetana');
    Route::get('charthumidity/{id}', [ChartsController::class, 'humidity'])->name('api.charthumidity');
    Route::get('charttemperature/{id}', [ChartsController::class, 'temperature'])->name('api.charttemperature');
    Route::view('karyawan', 'karyawan')->name('karyawan');
    Route::view('blog', 'blog')->name('blog');
    Route::view('addblog', 'addblog')->name('addblog');
    Route::view('profile', 'profile')->name('profile');

    Route::controller(RiwayatController::class)->prefix('/dashboard')->group(function () {
        Route::get('riwayat-temperature', 'riwayatTemperature')->name('riwayat.temperature');
        Route::get('riwayat-humidity', 'riwayatHumidity')->name('riwayat.humidity');


        Route::post('/data/amonia', 'getAmoniaData')->name('data.riwayatamonia');
        Route::post('/data/temperature', 'getTemperatureData')->name('data.riwayattemperature');
        Route::post('/data/metana', 'getMetanaData')->name('data.riwayatmetana');
        Route::post('/data/humidity', 'getHumidityData')->name('data.riwayathumidity');
        Route::post('/data/dioksida', 'getDioksidaData')->name('data.riwayatdioksida');

    });
    Route::get('export/ammonia', function (Request $request) {
        $startDate = $request->query('createFrom');
        $endDate = $request->query('createTo');
        return Excel::download(new AmmoniaExport($startDate, $endDate), 'ammonia_data.xlsx');
    })->name('export.ammonia');

    Route::get('export/temperature', function (Request $request) {
        $startDate = $request->input('createFrom');
        $endDate = $request->input('createTo');

        return Excel::download(new TemperatureExport($startDate, $endDate), 'temperature_data.xlsx');
    })->name('export.temperature');

    Route::get('export/humidity', function (Request $request) {
        $startDate = $request->input('createFrom');
        $endDate = $request->input('createTo');

        return Excel::download(new HumidityExport($startDate, $endDate), 'humidity_data.xlsx');
    })->name('export.humidity');

    Route::get('export/metana', function (Request $request) {
        $startDate = $request->input('createFrom');
        $endDate = $request->input('createTo');

        return Excel::download(new MetanaExport($startDate, $endDate), 'metana_data.xlsx');
    })->name('export.metana');

    Route::get('export/dioksida', function (Request $request) {
        $startDate = $request->input('createFrom');
        $endDate = $request->input('createTo');

        return Excel::download(new DioksidaExport($startDate, $endDate), 'dioksida_data.xlsx');
    })->name('export.dioksida');
});

require __DIR__.'/auth.php';
