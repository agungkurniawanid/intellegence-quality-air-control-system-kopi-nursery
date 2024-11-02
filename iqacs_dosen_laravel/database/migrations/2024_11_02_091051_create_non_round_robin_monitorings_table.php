<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('non_round_robin_monitorings', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('id_monitoring');
            $table->unsignedBigInteger('id_temperature');
            $table->unsignedBigInteger('id_humidity');
            $table->integer('waiting_time');
            $table->integer('turn_around_time');
            $table->timestamps();

            $table->foreign('id_monitoring')->references('id')->on('monitoring_result_round_robins');
            $table->foreign('id_temperature')->references('id')->on('temperature');
            $table->foreign('id_humidity')->references('id')->on('humidity');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('non_round_robin_monitorings');
    }
};
