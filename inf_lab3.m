%% setup
    clear;
    %close all;
    close;
    format shorteng
    format compact

%% filter
    fs = 48e3;
    fc = 8e3;
    [B,A] = butter(4,fc/(fs/2),'low');

    L = 1000;
    %x = randn(L, 1);
    x = 1*rand(L,1);
    % pl 0.1 1 10 ertekek

    y = filter(B, A, x);
    %plot(x)
    %hold on;
    %plot(y)

%% 1) LMS
    M_lms  = 10;
    mu_lms = .1/M_lms;
    [e,w]=mylms(mu_lms,M_lms,x,y);
    figure(1);
        plot(e);

    figure(2)
        
        [h1, f1] = freqz(B, A, 10240, fs);
        [h2, f2] = freqz(w, 1, 10240, fs);
        
        semilogx(f1, db(abs(h1)), 'LineWidth', 2);
        hold on
        semilogx(f2, db(abs(h2)), 'LineWidth', 2);
        xline(8e3, 'LineWidth', 2)
        grid on
        xlabel('Frequency [Hz]')
        ylabel('Amplitude [dB]')
        ylim([-50, 10]);
        hold off



%% 2) NLMS
    M_nlms  = 10;
    mu_nlms = 5/M_nlms;
    a = 1e-3;

    [e,w]=mynlms(mu_nlms,a,M_nlms,x,y);
    figure(3);
        plot(e);

    figure(4)
        
        [h3, f3] = freqz(B, A, 10240, fs);
        [h4, f4] = freqz(w, 1, 10240, fs);
        
        semilogx(f3, db(abs(h3)), 'LineWidth', 2);
        hold on
        semilogx(f4, db(abs(h4)), 'LineWidth', 2);
        xline(8e3, 'LineWidth', 2)
        grid on
        xlabel('Frequency [Hz]')
        ylabel('Amplitude [dB]')
        % ylim([-50, 10]);
        hold off

%% 3) FxLMS
    M_fxlms  = 0;
    mu_fxlms = 0;

